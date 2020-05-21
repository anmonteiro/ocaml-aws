open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module SignalResourceInput =
  struct
    type t =
      {
      stack_name: String.t
        [@ocaml.doc
          "<p>The stack name or unique stack ID that includes the resource that you want to signal.</p>"];
      logical_resource_id: String.t
        [@ocaml.doc
          "<p>The logical ID of the resource that you want to signal. The logical ID is the name of the resource that given in the template.</p>"];
      unique_id: String.t
        [@ocaml.doc
          "<p>A unique ID of the signal. When you signal Amazon EC2 instances or Auto Scaling groups, specify the instance ID that you are signaling as the unique ID. If you send multiple signals to a single resource (such as signaling a wait condition), each signal requires a different unique ID.</p>"];
      status: ResourceSignalStatus.t
        [@ocaml.doc
          "<p>The status of the signal, which is either success or failure. A failure signal causes AWS CloudFormation to immediately fail the stack creation or update.</p>"]}
    [@@ocaml.doc "<p>The input for the <a>SignalResource</a> action.</p>"]
    let make ~stack_name  ~logical_resource_id  ~unique_id  ~status  () =
      { stack_name; logical_resource_id; unique_id; status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("status", (ResourceSignalStatus.to_json v.status));
           Some ("unique_id", (String.to_json v.unique_id));
           Some
             ("logical_resource_id", (String.to_json v.logical_resource_id));
           Some ("stack_name", (String.to_json v.stack_name))])
    let parse xml =
      Some
        {
          stack_name =
            (Xml.required "StackName"
               (Util.option_bind (Xml.member "StackName" xml) String.parse));
          logical_resource_id =
            (Xml.required "LogicalResourceId"
               (Util.option_bind (Xml.member "LogicalResourceId" xml)
                  String.parse));
          unique_id =
            (Xml.required "UniqueId"
               (Util.option_bind (Xml.member "UniqueId" xml) String.parse));
          status =
            (Xml.required "Status"
               (Util.option_bind (Xml.member "Status" xml)
                  ResourceSignalStatus.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "StackName"
                    ([], (String.to_xml v.stack_name)))])
             @
             [Some
                (Ezxmlm.make_tag "LogicalResourceId"
                   ([], (String.to_xml v.logical_resource_id)))])
            @
            [Some
               (Ezxmlm.make_tag "UniqueId" ([], (String.to_xml v.unique_id)))])
           @
           [Some
              (Ezxmlm.make_tag "Status"
                 ([], (ResourceSignalStatus.to_xml v.status)))])
  end[@@ocaml.doc "<p>The input for the <a>SignalResource</a> action.</p>"]
module Output = Aws.BaseTypes.Unit
type input = SignalResourceInput.t
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
         [("Version", ["2010-05-15"]); ("Action", ["SignalResource"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (SignalResourceInput.to_query req))))) in
  (`POST, uri, (Headers.render (SignalResourceInput.to_headers req)), "")
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