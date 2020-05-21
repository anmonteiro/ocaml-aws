open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module TagResourceInput =
  struct
    type t =
      {
      resource_a_r_n: String.t
        [@ocaml.doc
          "<p>The ARN of the CloudWatch alarm that you're adding tags to. The ARN format is <code>arn:aws:cloudwatch:<i>Region</i>:<i>account-id</i>:alarm:<i>alarm-name</i> </code> </p>"];
      tags: TagList.t
        [@ocaml.doc
          "<p>The list of key-value pairs to associate with the alarm.</p>"]}
    let make ~resource_a_r_n  ~tags  () = { resource_a_r_n; tags }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagList.to_json v.tags));
           Some ("resource_a_r_n", (String.to_json v.resource_a_r_n))])
    let parse xml =
      Some
        {
          resource_a_r_n =
            (Xml.required "ResourceARN"
               (Util.option_bind (Xml.member "ResourceARN" xml) String.parse));
          tags =
            (Xml.required "Tags"
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "ResourceARN"
                  ([], (String.to_xml v.resource_a_r_n)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Tags" ([], (TagList.to_xml [x]))))
              v.tags))
  end
module Output = Aws.BaseTypes.Unit
type input = TagResourceInput.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "monitoring"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2010-08-01"]); ("Action", ["TagResource"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (TagResourceInput.to_query req))))) in
  (`POST, uri, (Headers.render (TagResourceInput.to_headers req)), "")
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