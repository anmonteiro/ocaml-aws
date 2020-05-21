open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteChangeSetInput =
  struct
    type t =
      {
      change_set_name: String.t
        [@ocaml.doc
          "<p>The name or Amazon Resource Name (ARN) of the change set that you want to delete.</p>"];
      stack_name: String.t option
        [@ocaml.doc
          "<p>If you specified the name of a change set to delete, specify the stack name or ID (ARN) that is associated with it.</p>"]}
    [@@ocaml.doc "<p>The input for the <a>DeleteChangeSet</a> action.</p>"]
    let make ~change_set_name  ?stack_name  () =
      { change_set_name; stack_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.stack_name
              (fun f -> ("stack_name", (String.to_json f)));
           Some ("change_set_name", (String.to_json v.change_set_name))])
    let parse xml =
      Some
        {
          change_set_name =
            (Xml.required "ChangeSetName"
               (Util.option_bind (Xml.member "ChangeSetName" xml)
                  String.parse));
          stack_name =
            (Util.option_bind (Xml.member "StackName" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "ChangeSetName"
                  ([], (String.to_xml v.change_set_name)))])
           @
           [Util.option_map v.stack_name
              (fun f -> Ezxmlm.make_tag "StackName" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>The input for the <a>DeleteChangeSet</a> action.</p>"]
module Output = Aws.BaseTypes.Unit
type input = DeleteChangeSetInput.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-05-15"]); ("Action", ["DeleteChangeSet"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteChangeSetInput.to_query req))))) in
  (`POST, uri, (Headers.render (DeleteChangeSetInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) = `Ok ()
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