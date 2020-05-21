open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RemoveTagsFromResourceMessage =
  struct
    type t =
      {
      resource_name: String.t
        [@ocaml.doc
          "<p>The Amazon RDS resource that the tags are removed from. This value is an Amazon Resource Name (ARN). For information about creating an ARN, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Tagging.ARN.html#USER_Tagging.ARN.Constructing\"> Constructing an ARN for Amazon RDS</a> in the <i>Amazon RDS User Guide.</i> </p>"];
      tag_keys: KeyList.t
        [@ocaml.doc "<p>The tag key (name) of the tag to be removed.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~resource_name  ~tag_keys  () = { resource_name; tag_keys }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tag_keys", (KeyList.to_json v.tag_keys));
           Some ("resource_name", (String.to_json v.resource_name))])
    let parse xml =
      Some
        {
          resource_name =
            (Xml.required "ResourceName"
               (Util.option_bind (Xml.member "ResourceName" xml) String.parse));
          tag_keys =
            (Xml.required "TagKeys"
               (Util.option_bind (Xml.member "TagKeys" xml) KeyList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "ResourceName"
                  ([], (String.to_xml v.resource_name)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "TagKeys" ([], (KeyList.to_xml [x]))))
              v.tag_keys))
  end[@@ocaml.doc "<p/>"]
module Output = Aws.BaseTypes.Unit
type input = RemoveTagsFromResourceMessage.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]);
         ("Action", ["RemoveTagsFromResource"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (RemoveTagsFromResourceMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (RemoveTagsFromResourceMessage.to_headers req)), "")
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