open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module StartInstancesRequest =
  struct
    type t =
      {
      instance_ids: InstanceIdStringList.t
        [@ocaml.doc "<p>The IDs of the instances.</p>"];
      additional_info: String.t option [@ocaml.doc "<p>Reserved.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~instance_ids  ?additional_info  ?dry_run  () =
      { instance_ids; additional_info; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.additional_info
             (fun f -> Query.Pair ("AdditionalInfo", (String.to_query f)));
           Some
             (Query.Pair
                ("InstanceId",
                  (InstanceIdStringList.to_query v.instance_ids)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.additional_info
             (fun f -> ("additional_info", (String.to_json f)));
           Some
             ("instance_ids", (InstanceIdStringList.to_json v.instance_ids))])
    let parse xml =
      Some
        {
          instance_ids =
            (Xml.required "InstanceId"
               (Util.option_bind (Xml.member "InstanceId" xml)
                  InstanceIdStringList.parse));
          additional_info =
            (Util.option_bind (Xml.member "additionalInfo" xml) String.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "InstanceId"
                        ([], (InstanceIdStringList.to_xml [x]))))
                v.instance_ids))
            @
            [Util.option_map v.additional_info
               (fun f ->
                  Ezxmlm.make_tag "additionalInfo" ([], (String.to_xml f)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end
module StartInstancesResult = StartInstancesResult
type input = StartInstancesRequest.t
type output = StartInstancesResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["StartInstances"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (StartInstancesRequest.to_query req))))) in
  (`POST, uri, (Headers.render (StartInstancesRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "StartInstancesResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp StartInstancesResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed StartInstancesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing StartInstancesResult - missing field in body or children: "
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