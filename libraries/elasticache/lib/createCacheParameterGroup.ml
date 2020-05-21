open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateCacheParameterGroupMessage =
  struct
    type t =
      {
      cache_parameter_group_name: String.t
        [@ocaml.doc
          "<p>A user-specified name for the cache parameter group.</p>"];
      cache_parameter_group_family: String.t
        [@ocaml.doc
          "<p>The name of the cache parameter group family that the cache parameter group can be used with.</p> <p>Valid values are: <code>memcached1.4</code> | <code>memcached1.5</code> | <code>redis2.6</code> | <code>redis2.8</code> | <code>redis3.2</code> | <code>redis4.0</code> | <code>redis5.0</code> | </p>"];
      description: String.t
        [@ocaml.doc
          "<p>A user-specified description for the cache parameter group.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>CreateCacheParameterGroup</code> operation.</p>"]
    let make ~cache_parameter_group_name  ~cache_parameter_group_family 
      ~description  () =
      { cache_parameter_group_name; cache_parameter_group_family; description
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("description", (String.to_json v.description));
           Some
             ("cache_parameter_group_family",
               (String.to_json v.cache_parameter_group_family));
           Some
             ("cache_parameter_group_name",
               (String.to_json v.cache_parameter_group_name))])
    let parse xml =
      Some
        {
          cache_parameter_group_name =
            (Xml.required "CacheParameterGroupName"
               (Util.option_bind (Xml.member "CacheParameterGroupName" xml)
                  String.parse));
          cache_parameter_group_family =
            (Xml.required "CacheParameterGroupFamily"
               (Util.option_bind (Xml.member "CacheParameterGroupFamily" xml)
                  String.parse));
          description =
            (Xml.required "Description"
               (Util.option_bind (Xml.member "Description" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "CacheParameterGroupName"
                   ([], (String.to_xml v.cache_parameter_group_name)))])
            @
            [Some
               (Ezxmlm.make_tag "CacheParameterGroupFamily"
                  ([], (String.to_xml v.cache_parameter_group_family)))])
           @
           [Some
              (Ezxmlm.make_tag "Description"
                 ([], (String.to_xml v.description)))])
  end[@@ocaml.doc
       "<p>Represents the input of a <code>CreateCacheParameterGroup</code> operation.</p>"]
module CreateCacheParameterGroupResult = CreateCacheParameterGroupResult
type input = CreateCacheParameterGroupMessage.t
type output = CreateCacheParameterGroupResult.t
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
         ("Action", ["CreateCacheParameterGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateCacheParameterGroupMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateCacheParameterGroupMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "CreateCacheParameterGroupResponse" (snd xml))
        (Xml.member "CreateCacheParameterGroupResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateCacheParameterGroupResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateCacheParameterGroupResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateCacheParameterGroupResult - missing field in body or children: "
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