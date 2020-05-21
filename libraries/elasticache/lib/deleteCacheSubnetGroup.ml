open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteCacheSubnetGroupMessage =
  struct
    type t =
      {
      cache_subnet_group_name: String.t
        [@ocaml.doc
          "<p>The name of the cache subnet group to delete.</p> <p>Constraints: Must contain no more than 255 alphanumeric characters or hyphens.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>DeleteCacheSubnetGroup</code> operation.</p>"]
    let make ~cache_subnet_group_name  () = { cache_subnet_group_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("cache_subnet_group_name",
                (String.to_json v.cache_subnet_group_name))])
    let parse xml =
      Some
        {
          cache_subnet_group_name =
            (Xml.required "CacheSubnetGroupName"
               (Util.option_bind (Xml.member "CacheSubnetGroupName" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "CacheSubnetGroupName"
                 ([], (String.to_xml v.cache_subnet_group_name)))])
  end[@@ocaml.doc
       "<p>Represents the input of a <code>DeleteCacheSubnetGroup</code> operation.</p>"]
module Output = Aws.BaseTypes.Unit
type input = DeleteCacheSubnetGroupMessage.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "elasticache"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2015-02-02"]);
         ("Action", ["DeleteCacheSubnetGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteCacheSubnetGroupMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (DeleteCacheSubnetGroupMessage.to_headers req)), "")
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