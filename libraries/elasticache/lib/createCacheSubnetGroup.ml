open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateCacheSubnetGroupMessage =
  struct
    type t =
      {
      cache_subnet_group_name: String.t
        [@ocaml.doc
          "<p>A name for the cache subnet group. This value is stored as a lowercase string.</p> <p>Constraints: Must contain no more than 255 alphanumeric characters or hyphens.</p> <p>Example: <code>mysubnetgroup</code> </p>"];
      cache_subnet_group_description: String.t
        [@ocaml.doc "<p>A description for the cache subnet group.</p>"];
      subnet_ids: SubnetIdentifierList.t
        [@ocaml.doc
          "<p>A list of VPC subnet IDs for the cache subnet group.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>CreateCacheSubnetGroup</code> operation.</p>"]
    let make ~cache_subnet_group_name  ~cache_subnet_group_description 
      ~subnet_ids  () =
      { cache_subnet_group_name; cache_subnet_group_description; subnet_ids }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("subnet_ids", (SubnetIdentifierList.to_json v.subnet_ids));
           Some
             ("cache_subnet_group_description",
               (String.to_json v.cache_subnet_group_description));
           Some
             ("cache_subnet_group_name",
               (String.to_json v.cache_subnet_group_name))])
    let parse xml =
      Some
        {
          cache_subnet_group_name =
            (Xml.required "CacheSubnetGroupName"
               (Util.option_bind (Xml.member "CacheSubnetGroupName" xml)
                  String.parse));
          cache_subnet_group_description =
            (Xml.required "CacheSubnetGroupDescription"
               (Util.option_bind
                  (Xml.member "CacheSubnetGroupDescription" xml) String.parse));
          subnet_ids =
            (Xml.required "SubnetIds"
               (Util.option_bind (Xml.member "SubnetIds" xml)
                  SubnetIdentifierList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "CacheSubnetGroupName"
                   ([], (String.to_xml v.cache_subnet_group_name)))])
            @
            [Some
               (Ezxmlm.make_tag "CacheSubnetGroupDescription"
                  ([], (String.to_xml v.cache_subnet_group_description)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "SubnetIds"
                      ([], (SubnetIdentifierList.to_xml [x])))) v.subnet_ids))
  end[@@ocaml.doc
       "<p>Represents the input of a <code>CreateCacheSubnetGroup</code> operation.</p>"]
module CreateCacheSubnetGroupResult = CreateCacheSubnetGroupResult
type input = CreateCacheSubnetGroupMessage.t
type output = CreateCacheSubnetGroupResult.t
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
         ("Action", ["CreateCacheSubnetGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateCacheSubnetGroupMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateCacheSubnetGroupMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "CreateCacheSubnetGroupResponse" (snd xml))
        (Xml.member "CreateCacheSubnetGroupResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateCacheSubnetGroupResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateCacheSubnetGroupResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateCacheSubnetGroupResult - missing field in body or children: "
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