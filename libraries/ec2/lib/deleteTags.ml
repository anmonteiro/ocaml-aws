open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteTagsRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      resources: ResourceIdList.t
        [@ocaml.doc
          "<p>The IDs of the resources, separated by spaces.</p> <p>Constraints: Up to 1000 resource IDs. We recommend breaking up this request into smaller batches.</p>"];
      tags: TagList.t
        [@ocaml.doc
          "<p>The tags to delete. Specify a tag key and an optional tag value to delete specific tags. If you specify a tag key without a tag value, we delete any tag with this key regardless of its value. If you specify a tag key with an empty string as the tag value, we delete the tag only if its value is an empty string.</p> <p>If you omit this parameter, we delete all user-defined tags for the specified resources. We do not delete AWS-generated tags (tags that have the <code>aws:</code> prefix).</p>"]}
    let make ?dry_run  ~resources  ?(tags= [])  () =
      { dry_run; resources; tags }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("Tag", (TagList.to_query v.tags)));
           Some
             (Query.Pair
                ("ResourceId", (ResourceIdList.to_query v.resources)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagList.to_json v.tags));
           Some ("resources", (ResourceIdList.to_json v.resources));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          resources =
            (Xml.required "resourceId"
               (Util.option_bind (Xml.member "resourceId" xml)
                  ResourceIdList.parse));
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "tag" xml) TagList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.dry_run
                (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "resourceId"
                       ([], (ResourceIdList.to_xml [x])))) v.resources))
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "tag" ([], (TagList.to_xml [x]))))
              v.tags))
  end
module Output = Aws.BaseTypes.Unit
type input = DeleteTagsRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2016-11-15"]); ("Action", ["DeleteTags"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteTagsRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DeleteTagsRequest.to_headers req)), "")
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