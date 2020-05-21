open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ChangeTagsForResourceRequest =
  struct
    type t =
      {
      resource_type: TagResourceType.t
        [@ocaml.doc
          "<p>The type of the resource.</p> <ul> <li> <p>The resource type for health checks is <code>healthcheck</code>.</p> </li> <li> <p>The resource type for hosted zones is <code>hostedzone</code>.</p> </li> </ul>"];
      resource_id: String.t
        [@ocaml.doc
          "<p>The ID of the resource for which you want to add, change, or delete tags.</p>"];
      add_tags: TagList.t
        [@ocaml.doc
          "<p>A complex type that contains a list of the tags that you want to add to the specified health check or hosted zone and/or the tags that you want to edit <code>Value</code> for.</p> <p>You can add a maximum of 10 tags to a health check or a hosted zone.</p>"];
      remove_tag_keys: TagKeyList.t
        [@ocaml.doc
          "<p>A complex type that contains a list of the tags that you want to delete from the specified health check or hosted zone. You can specify up to 10 keys.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about the tags that you want to add, edit, or delete.</p>"]
    let make ~resource_type  ~resource_id  ?(add_tags= []) 
      ?(remove_tag_keys= [])  () =
      { resource_type; resource_id; add_tags; remove_tag_keys }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("remove_tag_keys", (TagKeyList.to_json v.remove_tag_keys));
           Some ("add_tags", (TagList.to_json v.add_tags));
           Some ("resource_id", (String.to_json v.resource_id));
           Some ("resource_type", (TagResourceType.to_json v.resource_type))])
    let parse xml =
      Some
        {
          resource_type =
            (Xml.required "ResourceType"
               (Util.option_bind (Xml.member "ResourceType" xml)
                  TagResourceType.parse));
          resource_id =
            (Xml.required "ResourceId"
               (Util.option_bind (Xml.member "ResourceId" xml) String.parse));
          add_tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "AddTags" xml) TagList.parse));
          remove_tag_keys =
            (Util.of_option []
               (Util.option_bind (Xml.member "RemoveTagKeys" xml)
                  TagKeyList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "ResourceType"
                    ([], (TagResourceType.to_xml v.resource_type)))])
             @
             [Some
                (Ezxmlm.make_tag "ResourceId"
                   ([], (String.to_xml v.resource_id)))])
            @
            (List.map
               (fun x ->
                  Some (Ezxmlm.make_tag "AddTags" ([], (TagList.to_xml [x]))))
               v.add_tags))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "RemoveTagKeys"
                      ([], (TagKeyList.to_xml [x])))) v.remove_tag_keys))
  end[@@ocaml.doc
       "<p>A complex type that contains information about the tags that you want to add, edit, or delete.</p>"]
module Output = Aws.BaseTypes.Unit
type input = ChangeTagsForResourceRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            ((("/2013-04-01/tags/" ^
                 (TagResourceType.to_string
                    req.ChangeTagsForResourceRequest.resource_type))
                ^ "/")
               ^ req.ChangeTagsForResourceRequest.resource_id)))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (ChangeTagsForResourceRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (ChangeTagsForResourceRequest.to_headers req)), "")
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