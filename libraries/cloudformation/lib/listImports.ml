open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListImportsInput =
  struct
    type t =
      {
      export_name: String.t
        [@ocaml.doc
          "<p>The name of the exported output value. AWS CloudFormation returns the stack names that are importing this value. </p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>A string (provided by the <a>ListImports</a> response output) that identifies the next page of stacks that are importing the specified exported output value. </p>"]}
    let make ~export_name  ?next_token  () = { export_name; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("export_name", (String.to_json v.export_name))])
    let parse xml =
      Some
        {
          export_name =
            (Xml.required "ExportName"
               (Util.option_bind (Xml.member "ExportName" xml) String.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "ExportName"
                  ([], (String.to_xml v.export_name)))])
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module ListImportsOutput = ListImportsOutput
type input = ListImportsInput.t
type output = ListImportsOutput.t
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2010-05-15"]); ("Action", ["ListImports"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ListImportsInput.to_query req))))) in
  (`POST, uri, (Headers.render (ListImportsInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "ListImportsResponse" (snd xml))
        (Xml.member "ListImportsResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ListImportsOutput.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ListImportsOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListImportsOutput - missing field in body or children: "
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