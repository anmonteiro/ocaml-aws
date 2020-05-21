open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module AddTagsToResourceRequest =
  struct
    type t =
      {
      resource_type: ResourceTypeForTagging.t
        [@ocaml.doc
          "<p>Specifies the type of resource you are tagging.</p> <note> <p>The ManagedInstance type for this API action is for on-premises managed instances. You must specify the name of the managed instance in the following format: mi-ID_number. For example, mi-1a2b3c4d5e6f.</p> </note>"];
      resource_id: String.t
        [@ocaml.doc
          "<p>The resource ID you want to tag.</p> <p>Use the ID of the resource. Here are some examples:</p> <p>ManagedInstance: mi-012345abcde</p> <p>MaintenanceWindow: mw-012345abcde</p> <p>PatchBaseline: pb-012345abcde</p> <p>For the Document and Parameter values, use the name of the resource.</p> <note> <p>The ManagedInstance type for this API action is only for on-premises managed instances. You must specify the name of the managed instance in the following format: mi-ID_number. For example, mi-1a2b3c4d5e6f.</p> </note>"];
      tags: TagList.t
        [@ocaml.doc
          "<p> One or more tags. The value parameter is required, but if you don't want the tag to have a value, specify the parameter with no value, and we set the value to an empty string. </p> <important> <p>Do not enter personally identifiable information in this field.</p> </important>"]}
    let make ~resource_type  ~resource_id  ~tags  () =
      { resource_type; resource_id; tags }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagList.to_json v.tags));
           Some ("resource_id", (String.to_json v.resource_id));
           Some
             ("resource_type",
               (ResourceTypeForTagging.to_json v.resource_type))])
    let of_json j =
      {
        resource_type =
          (ResourceTypeForTagging.of_json
             (Util.of_option_exn (Json.lookup j "resource_type")));
        resource_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "resource_id")));
        tags = (TagList.of_json (Util.of_option_exn (Json.lookup j "tags")))
      }
  end
module Output = Aws.BaseTypes.Unit
type input = AddTagsToResourceRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "ssm"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (AddTagsToResourceRequest.to_query req)))) in
  (`POST, uri, (Headers.render (AddTagsToResourceRequest.to_headers req)),
    "")
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