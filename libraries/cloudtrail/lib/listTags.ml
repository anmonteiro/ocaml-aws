open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListTagsRequest =
  struct
    type t =
      {
      resource_id_list: ResourceIdList.t
        [@ocaml.doc
          "<p>Specifies a list of trail ARNs whose tags will be listed. The list has a limit of 20 ARNs. The format of a trail ARN is:</p> <p> <code>arn:aws:cloudtrail:us-east-2:123456789012:trail/MyTrail</code> </p>"];
      next_token: String.t option
        [@ocaml.doc "<p>Reserved for future use.</p>"]}[@@ocaml.doc
                                                         "<p>Specifies a list of trail tags to return.</p>"]
    let make ~resource_id_list  ?next_token  () =
      { resource_id_list; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("resource_id_list",
               (ResourceIdList.to_json v.resource_id_list))])
    let of_json j =
      {
        resource_id_list =
          (ResourceIdList.of_json
             (Util.of_option_exn (Json.lookup j "resource_id_list")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end[@@ocaml.doc "<p>Specifies a list of trail tags to return.</p>"]
module ListTagsResponse = ListTagsResponse
type input = ListTagsRequest.t
type output = ListTagsResponse.t
type error = Errors_internal.t
let streaming = false
let service = "cloudtrail"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (Util.drop_empty
         (Uri.query_of_encoded (Query.render (ListTagsRequest.to_query req)))) in
  (`POST, uri, (Headers.render (ListTagsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (ListTagsResponse.of_json json)
  with
  | Yojson.Json_error msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing JSON: " ^ msg) })
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