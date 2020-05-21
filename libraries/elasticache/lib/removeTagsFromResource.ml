open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RemoveTagsFromResourceMessage =
  struct
    type t =
      {
      resource_name: String.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the resource from which you want the tags removed, for example <code>arn:aws:elasticache:us-west-2:0123456789:cluster:myCluster</code> or <code>arn:aws:elasticache:us-west-2:0123456789:snapshot:mySnapshot</code>.</p> <p>For more information about ARNs, see <a href=\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a>.</p>"];
      tag_keys: KeyList.t
        [@ocaml.doc
          "<p>A list of <code>TagKeys</code> identifying the tags you want removed from the named resource.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>RemoveTagsFromResource</code> operation.</p>"]
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
  end[@@ocaml.doc
       "<p>Represents the input of a <code>RemoveTagsFromResource</code> operation.</p>"]
module TagListMessage = TagListMessage
type input = RemoveTagsFromResourceMessage.t
type output = TagListMessage.t
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
         ("Action", ["RemoveTagsFromResource"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (RemoveTagsFromResourceMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (RemoveTagsFromResourceMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "RemoveTagsFromResourceResponse" (snd xml))
        (Xml.member "RemoveTagsFromResourceResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp TagListMessage.parse)
          (BadResponse
             { body; message = "Could not find well formed TagListMessage." })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing TagListMessage - missing field in body or children: "
                      ^ msg)
               })
  with
  | Failure msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing xml: " ^ msg) })
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