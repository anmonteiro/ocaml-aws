open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UpdateTerminationProtectionInput =
  struct
    type t =
      {
      enable_termination_protection: Boolean.t
        [@ocaml.doc
          "<p>Whether to enable termination protection on the specified stack.</p>"];
      stack_name: String.t
        [@ocaml.doc
          "<p>The name or unique ID of the stack for which you want to set termination protection.</p>"]}
    let make ~enable_termination_protection  ~stack_name  () =
      { enable_termination_protection; stack_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("stack_name", (String.to_json v.stack_name));
           Some
             ("enable_termination_protection",
               (Boolean.to_json v.enable_termination_protection))])
    let parse xml =
      Some
        {
          enable_termination_protection =
            (Xml.required "EnableTerminationProtection"
               (Util.option_bind
                  (Xml.member "EnableTerminationProtection" xml)
                  Boolean.parse));
          stack_name =
            (Xml.required "StackName"
               (Util.option_bind (Xml.member "StackName" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "EnableTerminationProtection"
                  ([], (Boolean.to_xml v.enable_termination_protection)))])
           @
           [Some
              (Ezxmlm.make_tag "StackName" ([], (String.to_xml v.stack_name)))])
  end
module UpdateTerminationProtectionOutput = UpdateTerminationProtectionOutput
type input = UpdateTerminationProtectionInput.t
type output = UpdateTerminationProtectionOutput.t
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-05-15"]);
         ("Action", ["UpdateTerminationProtection"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (UpdateTerminationProtectionInput.to_query req))))) in
  (`POST, uri,
    (Headers.render (UpdateTerminationProtectionInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "UpdateTerminationProtectionResponse" (snd xml))
        (Xml.member "UpdateTerminationProtectionResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp UpdateTerminationProtectionOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed UpdateTerminationProtectionOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing UpdateTerminationProtectionOutput - missing field in body or children: "
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