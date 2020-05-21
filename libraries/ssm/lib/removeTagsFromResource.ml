open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RemoveTagsFromResourceRequest =
  struct
    type t =
      {
      resource_type: ResourceTypeForTagging.t
        [@ocaml.doc
          "<p>The type of resource from which you want to remove a tag.</p> <note> <p>The ManagedInstance type for this API action is only for on-premises managed instances. Specify the name of the managed instance in the following format: mi-ID_number. For example, mi-1a2b3c4d5e6f.</p> </note>"];
      resource_id: String.t
        [@ocaml.doc
          "<p>The ID of the resource from which you want to remove tags. For example:</p> <p>ManagedInstance: mi-012345abcde</p> <p>MaintenanceWindow: mw-012345abcde</p> <p>PatchBaseline: pb-012345abcde</p> <p>For the Document and Parameter values, use the name of the resource.</p> <note> <p>The ManagedInstance type for this API action is only for on-premises managed instances. Specify the name of the managed instance in the following format: mi-ID_number. For example, mi-1a2b3c4d5e6f.</p> </note>"];
      tag_keys: KeyList.t
        [@ocaml.doc
          "<p>Tag keys that you want to remove from the specified resource.</p>"]}
    let make ~resource_type  ~resource_id  ~tag_keys  () =
      { resource_type; resource_id; tag_keys }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tag_keys", (KeyList.to_json v.tag_keys));
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
        tag_keys =
          (KeyList.of_json (Util.of_option_exn (Json.lookup j "tag_keys")))
      }
  end
module Output = Aws.BaseTypes.Unit
type input = RemoveTagsFromResourceRequest.t
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
            (Query.render (RemoveTagsFromResourceRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (RemoveTagsFromResourceRequest.to_headers req)), "")
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