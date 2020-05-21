open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PurchaseScheduledInstancesRequest =
  struct
    type t =
      {
      client_token: String.t option
        [@ocaml.doc
          "<p>Unique, case-sensitive identifier that ensures the idempotency of the request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html\">Ensuring Idempotency</a>.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      purchase_requests: PurchaseRequestSet.t
        [@ocaml.doc "<p>The purchase requests.</p>"]}[@@ocaml.doc
                                                       "<p>Contains the parameters for PurchaseScheduledInstances.</p>"]
    let make ?client_token  ?dry_run  ~purchase_requests  () =
      { client_token; dry_run; purchase_requests }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("PurchaseRequest",
                   (PurchaseRequestSet.to_query v.purchase_requests)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.client_token
             (fun f -> Query.Pair ("ClientToken", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("purchase_requests",
                (PurchaseRequestSet.to_json v.purchase_requests));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)))])
    let parse xml =
      Some
        {
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse);
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          purchase_requests =
            (Xml.required "PurchaseRequest"
               (Util.option_bind (Xml.member "PurchaseRequest" xml)
                  PurchaseRequestSet.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.client_token
                (fun f ->
                   Ezxmlm.make_tag "ClientToken" ([], (String.to_xml f)))])
            @
            [Util.option_map v.dry_run
               (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "PurchaseRequest"
                      ([], (PurchaseRequestSet.to_xml [x]))))
              v.purchase_requests))
  end[@@ocaml.doc
       "<p>Contains the parameters for PurchaseScheduledInstances.</p>"]
module PurchaseScheduledInstancesResult = PurchaseScheduledInstancesResult
type input = PurchaseScheduledInstancesRequest.t
type output = PurchaseScheduledInstancesResult.t
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
         ("Action", ["PurchaseScheduledInstances"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (PurchaseScheduledInstancesRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (PurchaseScheduledInstancesRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "PurchaseScheduledInstancesResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp PurchaseScheduledInstancesResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed PurchaseScheduledInstancesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing PurchaseScheduledInstancesResult - missing field in body or children: "
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