open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DetectStackDriftInput =
  struct
    type t =
      {
      stack_name: String.t
        [@ocaml.doc
          "<p>The name of the stack for which you want to detect drift. </p>"];
      logical_resource_ids: LogicalResourceIds.t
        [@ocaml.doc
          "<p>The logical names of any resources you want to use as filters.</p>"]}
    let make ~stack_name  ?(logical_resource_ids= [])  () =
      { stack_name; logical_resource_ids }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("logical_resource_ids",
                (LogicalResourceIds.to_json v.logical_resource_ids));
           Some ("stack_name", (String.to_json v.stack_name))])
    let parse xml =
      Some
        {
          stack_name =
            (Xml.required "StackName"
               (Util.option_bind (Xml.member "StackName" xml) String.parse));
          logical_resource_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "LogicalResourceIds" xml)
                  LogicalResourceIds.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "StackName"
                  ([], (String.to_xml v.stack_name)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "LogicalResourceIds"
                      ([], (LogicalResourceIds.to_xml [x]))))
              v.logical_resource_ids))
  end
module DetectStackDriftOutput = DetectStackDriftOutput
type input = DetectStackDriftInput.t
type output = DetectStackDriftOutput.t
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-05-15"]); ("Action", ["DetectStackDrift"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DetectStackDriftInput.to_query req))))) in
  (`POST, uri, (Headers.render (DetectStackDriftInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DetectStackDriftResponse" (snd xml))
        (Xml.member "DetectStackDriftResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DetectStackDriftOutput.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed DetectStackDriftOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DetectStackDriftOutput - missing field in body or children: "
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