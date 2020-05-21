open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module AcceptReservedInstancesExchangeQuoteRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      reserved_instance_ids: ReservedInstanceIdSet.t
        [@ocaml.doc
          "<p>The IDs of the Convertible Reserved Instances to exchange for another Convertible Reserved Instance of the same or higher value.</p>"];
      target_configurations: TargetConfigurationRequestSet.t
        [@ocaml.doc
          "<p>The configuration of the target Convertible Reserved Instance to exchange for your current Convertible Reserved Instances.</p>"]}
    [@@ocaml.doc "<p>Contains the parameters for accepting the quote.</p>"]
    let make ?dry_run  ~reserved_instance_ids  ?(target_configurations= []) 
      () = { dry_run; reserved_instance_ids; target_configurations }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("TargetConfiguration",
                   (TargetConfigurationRequestSet.to_query
                      v.target_configurations)));
           Some
             (Query.Pair
                ("ReservedInstanceId",
                  (ReservedInstanceIdSet.to_query v.reserved_instance_ids)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("target_configurations",
                (TargetConfigurationRequestSet.to_json
                   v.target_configurations));
           Some
             ("reserved_instance_ids",
               (ReservedInstanceIdSet.to_json v.reserved_instance_ids));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          reserved_instance_ids =
            (Xml.required "ReservedInstanceId"
               (Util.option_bind (Xml.member "ReservedInstanceId" xml)
                  ReservedInstanceIdSet.parse));
          target_configurations =
            (Util.of_option []
               (Util.option_bind (Xml.member "TargetConfiguration" xml)
                  TargetConfigurationRequestSet.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.dry_run
                (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "ReservedInstanceId"
                       ([], (ReservedInstanceIdSet.to_xml [x]))))
               v.reserved_instance_ids))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "TargetConfiguration"
                      ([], (TargetConfigurationRequestSet.to_xml [x]))))
              v.target_configurations))
  end[@@ocaml.doc "<p>Contains the parameters for accepting the quote.</p>"]
module AcceptReservedInstancesExchangeQuoteResult =
  AcceptReservedInstancesExchangeQuoteResult
type input = AcceptReservedInstancesExchangeQuoteRequest.t
type output = AcceptReservedInstancesExchangeQuoteResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]);
         ("Action", ["AcceptReservedInstancesExchangeQuote"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (AcceptReservedInstancesExchangeQuoteRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render
       (AcceptReservedInstancesExchangeQuoteRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "AcceptReservedInstancesExchangeQuoteResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             AcceptReservedInstancesExchangeQuoteResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed AcceptReservedInstancesExchangeQuoteResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing AcceptReservedInstancesExchangeQuoteResult - missing field in body or children: "
                      ^ msg)
               })
  with
  | Failure msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing xml: " ^ msg) })
let parse_error code err =
  let errors = [] @ Errors_internal.common in
  match Errors_internal.of_string err with
  | Some v ->
      if
        (List.mem v errors) &&
          ((match Errors_internal.to_http_code v with
            | Some x -> x = code
            | None -> true))
      then Some v
      else None
  | None -> None