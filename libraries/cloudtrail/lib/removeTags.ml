open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RemoveTagsRequest =
  struct
    type t =
      {
      resource_id: String.t
        [@ocaml.doc
          "<p>Specifies the ARN of the trail from which tags should be removed. The format of a trail ARN is:</p> <p> <code>arn:aws:cloudtrail:us-east-2:123456789012:trail/MyTrail</code> </p>"];
      tags_list: TagsList.t
        [@ocaml.doc "<p>Specifies a list of tags to be removed.</p>"]}
    [@@ocaml.doc "<p>Specifies the tags to remove from a trail.</p>"]
    let make ~resource_id  ?(tags_list= [])  () = { resource_id; tags_list }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags_list", (TagsList.to_json v.tags_list));
           Some ("resource_id", (String.to_json v.resource_id))])
    let of_json j =
      {
        resource_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "resource_id")));
        tags_list =
          (TagsList.of_json (Util.of_option_exn (Json.lookup j "tags_list")))
      }
  end[@@ocaml.doc "<p>Specifies the tags to remove from a trail.</p>"]
module Output = Aws.BaseTypes.Unit
type input = RemoveTagsRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "cloudtrail"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (RemoveTagsRequest.to_query req)))) in
  (`POST, uri, (Headers.render (RemoveTagsRequest.to_headers req)), "")
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