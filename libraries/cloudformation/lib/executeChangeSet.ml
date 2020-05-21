open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ExecuteChangeSetInput =
  struct
    type t =
      {
      change_set_name: String.t
        [@ocaml.doc
          "<p>The name or ARN of the change set that you want use to update the specified stack.</p>"];
      stack_name: String.t option
        [@ocaml.doc
          "<p>If you specified the name of a change set, specify the stack name or ID (ARN) that is associated with the change set you want to execute.</p>"];
      client_request_token: String.t option
        [@ocaml.doc
          "<p>A unique identifier for this <code>ExecuteChangeSet</code> request. Specify this token if you plan to retry requests so that AWS CloudFormation knows that you're not attempting to execute a change set to update a stack with the same name. You might retry <code>ExecuteChangeSet</code> requests to ensure that AWS CloudFormation successfully received them.</p>"]}
    [@@ocaml.doc "<p>The input for the <a>ExecuteChangeSet</a> action.</p>"]
    let make ~change_set_name  ?stack_name  ?client_request_token  () =
      { change_set_name; stack_name; client_request_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.client_request_token
              (fun f -> ("client_request_token", (String.to_json f)));
           Util.option_map v.stack_name
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
            (Util.option_bind (Xml.member "StackName" xml) String.parse);
          client_request_token =
            (Util.option_bind (Xml.member "ClientRequestToken" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "ChangeSetName"
                   ([], (String.to_xml v.change_set_name)))])
            @
            [Util.option_map v.stack_name
               (fun f -> Ezxmlm.make_tag "StackName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.client_request_token
              (fun f ->
                 Ezxmlm.make_tag "ClientRequestToken" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>The input for the <a>ExecuteChangeSet</a> action.</p>"]
module Output = Aws.BaseTypes.Unit
type input = ExecuteChangeSetInput.t
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
         [("Version", ["2010-05-15"]); ("Action", ["ExecuteChangeSet"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ExecuteChangeSetInput.to_query req))))) in
  (`POST, uri, (Headers.render (ExecuteChangeSetInput.to_headers req)), "")
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