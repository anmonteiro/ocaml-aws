open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UntagResourceInput =
  struct
    type t =
      {
      resource_a_r_n: String.t
        [@ocaml.doc
          "<p>The ARN of the CloudWatch resource that you're removing tags from. For more information on ARN format, see <a href=\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-cloudwatch\">Example ARNs</a> in the <i>Amazon Web Services General Reference</i>.</p>"];
      tag_keys: TagKeyList.t
        [@ocaml.doc
          "<p>The list of tag keys to remove from the resource.</p>"]}
    let make ~resource_a_r_n  ~tag_keys  () = { resource_a_r_n; tag_keys }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tag_keys", (TagKeyList.to_json v.tag_keys));
           Some ("resource_a_r_n", (String.to_json v.resource_a_r_n))])
    let parse xml =
      Some
        {
          resource_a_r_n =
            (Xml.required "ResourceARN"
               (Util.option_bind (Xml.member "ResourceARN" xml) String.parse));
          tag_keys =
            (Xml.required "TagKeys"
               (Util.option_bind (Xml.member "TagKeys" xml) TagKeyList.parse))
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
                 Some
                   (Ezxmlm.make_tag "TagKeys" ([], (TagKeyList.to_xml [x]))))
              v.tag_keys))
  end
module Output = Aws.BaseTypes.Unit
type input = UntagResourceInput.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "monitoring"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-08-01"]); ("Action", ["UntagResource"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (UntagResourceInput.to_query req))))) in
  (`POST, uri, (Headers.render (UntagResourceInput.to_headers req)), "")
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