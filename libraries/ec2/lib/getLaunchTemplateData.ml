open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetLaunchTemplateDataRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      instance_id: String.t [@ocaml.doc "<p>The ID of the instance.</p>"]}
    let make ?dry_run  ~instance_id  () = { dry_run; instance_id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("InstanceId", (String.to_query v.instance_id)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("instance_id", (String.to_json v.instance_id));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          instance_id =
            (Xml.required "InstanceId"
               (Util.option_bind (Xml.member "InstanceId" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.dry_run
               (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "InstanceId"
                 ([], (String.to_xml v.instance_id)))])
  end
module GetLaunchTemplateDataResult = GetLaunchTemplateDataResult
type input = GetLaunchTemplateDataRequest.t
type output = GetLaunchTemplateDataResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["GetLaunchTemplateData"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (GetLaunchTemplateDataRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (GetLaunchTemplateDataRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "GetLaunchTemplateDataResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp GetLaunchTemplateDataResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed GetLaunchTemplateDataResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing GetLaunchTemplateDataResult - missing field in body or children: "
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