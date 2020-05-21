open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyCacheSubnetGroupMessage =
  struct
    type t =
      {
      cache_subnet_group_name: String.t
        [@ocaml.doc
          "<p>The name for the cache subnet group. This value is stored as a lowercase string.</p> <p>Constraints: Must contain no more than 255 alphanumeric characters or hyphens.</p> <p>Example: <code>mysubnetgroup</code> </p>"];
      cache_subnet_group_description: String.t option
        [@ocaml.doc "<p>A description of the cache subnet group.</p>"];
      subnet_ids: SubnetIdentifierList.t
        [@ocaml.doc "<p>The EC2 subnet IDs for the cache subnet group.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>ModifyCacheSubnetGroup</code> operation.</p>"]
    let make ~cache_subnet_group_name  ?cache_subnet_group_description 
      ?(subnet_ids= [])  () =
      { cache_subnet_group_name; cache_subnet_group_description; subnet_ids }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("subnet_ids", (SubnetIdentifierList.to_json v.subnet_ids));
           Util.option_map v.cache_subnet_group_description
             (fun f -> ("cache_subnet_group_description", (String.to_json f)));
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
            (Util.option_bind (Xml.member "CacheSubnetGroupDescription" xml)
               String.parse);
          subnet_ids =
            (Util.of_option []
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
            [Util.option_map v.cache_subnet_group_description
               (fun f ->
                  Ezxmlm.make_tag "CacheSubnetGroupDescription"
                    ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "SubnetIds"
                      ([], (SubnetIdentifierList.to_xml [x])))) v.subnet_ids))
  end[@@ocaml.doc
       "<p>Represents the input of a <code>ModifyCacheSubnetGroup</code> operation.</p>"]
module ModifyCacheSubnetGroupResult = ModifyCacheSubnetGroupResult
type input = ModifyCacheSubnetGroupMessage.t
type output = ModifyCacheSubnetGroupResult.t
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
         ("Action", ["ModifyCacheSubnetGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyCacheSubnetGroupMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifyCacheSubnetGroupMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "ModifyCacheSubnetGroupResponse" (snd xml))
        (Xml.member "ModifyCacheSubnetGroupResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ModifyCacheSubnetGroupResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyCacheSubnetGroupResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyCacheSubnetGroupResult - missing field in body or children: "
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