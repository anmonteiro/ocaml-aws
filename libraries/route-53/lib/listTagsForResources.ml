open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListTagsForResourcesRequest =
  struct
    type t =
      {
      resource_type: TagResourceType.t
        [@ocaml.doc
          "<p>The type of the resources.</p> <ul> <li> <p>The resource type for health checks is <code>healthcheck</code>.</p> </li> <li> <p>The resource type for hosted zones is <code>hostedzone</code>.</p> </li> </ul>"];
      resource_ids: TagResourceIdList.t
        [@ocaml.doc
          "<p>A complex type that contains the ResourceId element for each resource for which you want to get a list of tags.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about the health checks or hosted zones for which you want to list tags.</p>"]
    let make ~resource_type  ~resource_ids  () =
      { resource_type; resource_ids }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("resource_ids", (TagResourceIdList.to_json v.resource_ids));
           Some ("resource_type", (TagResourceType.to_json v.resource_type))])
    let parse xml =
      Some
        {
          resource_type =
            (Xml.required "ResourceType"
               (Util.option_bind (Xml.member "ResourceType" xml)
                  TagResourceType.parse));
          resource_ids =
            (Xml.required "ResourceIds"
               (Util.option_bind (Xml.member "ResourceIds" xml)
                  TagResourceIdList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "ResourceType"
                  ([], (TagResourceType.to_xml v.resource_type)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ResourceIds"
                      ([], (TagResourceIdList.to_xml [x])))) v.resource_ids))
  end[@@ocaml.doc
       "<p>A complex type that contains information about the health checks or hosted zones for which you want to list tags.</p>"]
module ListTagsForResourcesResponse = ListTagsForResourcesResponse
type input = ListTagsForResourcesRequest.t
type output = ListTagsForResourcesResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            ("/2013-04-01/tags/" ^
               (TagResourceType.to_string
                  req.ListTagsForResourcesRequest.resource_type))))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (ListTagsForResourcesRequest.to_query req)))) in
  (`POST, uri, (Headers.render (ListTagsForResourcesRequest.to_headers req)),
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
               "Could not find well formed ListTagsForResourcesResponse.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ListTagsForResourcesResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ListTagsForResourcesResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListTagsForResourcesResponse - missing field in body or children: "
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