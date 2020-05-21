open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateCacheSecurityGroupMessage =
  struct
    type t =
      {
      cache_security_group_name: String.t
        [@ocaml.doc
          "<p>A name for the cache security group. This value is stored as a lowercase string.</p> <p>Constraints: Must contain no more than 255 alphanumeric characters. Cannot be the word \"Default\".</p> <p>Example: <code>mysecuritygroup</code> </p>"];
      description: String.t
        [@ocaml.doc "<p>A description for the cache security group.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>CreateCacheSecurityGroup</code> operation.</p>"]
    let make ~cache_security_group_name  ~description  () =
      { cache_security_group_name; description }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("description", (String.to_json v.description));
           Some
             ("cache_security_group_name",
               (String.to_json v.cache_security_group_name))])
    let parse xml =
      Some
        {
          cache_security_group_name =
            (Xml.required "CacheSecurityGroupName"
               (Util.option_bind (Xml.member "CacheSecurityGroupName" xml)
                  String.parse));
          description =
            (Xml.required "Description"
               (Util.option_bind (Xml.member "Description" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "CacheSecurityGroupName"
                  ([], (String.to_xml v.cache_security_group_name)))])
           @
           [Some
              (Ezxmlm.make_tag "Description"
                 ([], (String.to_xml v.description)))])
  end[@@ocaml.doc
       "<p>Represents the input of a <code>CreateCacheSecurityGroup</code> operation.</p>"]
module CreateCacheSecurityGroupResult = CreateCacheSecurityGroupResult
type input = CreateCacheSecurityGroupMessage.t
type output = CreateCacheSecurityGroupResult.t
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
         ("Action", ["CreateCacheSecurityGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateCacheSecurityGroupMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateCacheSecurityGroupMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "CreateCacheSecurityGroupResponse" (snd xml))
        (Xml.member "CreateCacheSecurityGroupResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateCacheSecurityGroupResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateCacheSecurityGroupResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateCacheSecurityGroupResult - missing field in body or children: "
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