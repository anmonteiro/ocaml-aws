open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListTagsForResourceRequest =
  struct
    type t =
      {
      resource_type: TagResourceType.t
        [@ocaml.doc
          "<p>The type of the resource.</p> <ul> <li> <p>The resource type for health checks is <code>healthcheck</code>.</p> </li> <li> <p>The resource type for hosted zones is <code>hostedzone</code>.</p> </li> </ul>"];
      resource_id: String.t
        [@ocaml.doc
          "<p>The ID of the resource for which you want to retrieve tags.</p>"]}
    [@@ocaml.doc
      "<p>A complex type containing information about a request for a list of the tags that are associated with an individual resource.</p>"]
    let make ~resource_type  ~resource_id  () =
      { resource_type; resource_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("resource_id", (String.to_json v.resource_id));
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
               (Util.option_bind (Xml.member "ResourceId" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "ResourceType"
                  ([], (TagResourceType.to_xml v.resource_type)))])
           @
           [Some
              (Ezxmlm.make_tag "ResourceId"
                 ([], (String.to_xml v.resource_id)))])
  end[@@ocaml.doc
       "<p>A complex type containing information about a request for a list of the tags that are associated with an individual resource.</p>"]
module ListTagsForResourceResponse = ListTagsForResourceResponse
type input = ListTagsForResourceRequest.t
type output = ListTagsForResourceResponse.t
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
                    req.ListTagsForResourceRequest.resource_type))
                ^ "/")
               ^ req.ListTagsForResourceRequest.resource_id)))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (ListTagsForResourceRequest.to_query req)))) in
  (`GET, uri, (Headers.render (ListTagsForResourceRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      match List.hd (snd xml) with
      | `El (_, xs) -> Some xs
      | _ ->
          raise
            (Failure
               "Could not find well formed ListTagsForResourceResponse.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ListTagsForResourceResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ListTagsForResourceResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListTagsForResourceResponse - missing field in body or children: "
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