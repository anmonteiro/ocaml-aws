open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeTrailsRequest =
  struct
    type t =
      {
      trail_name_list: TrailNameList.t
        [@ocaml.doc
          "<p>Specifies a list of trail names, trail ARNs, or both, of the trails to describe. The format of a trail ARN is:</p> <p> <code>arn:aws:cloudtrail:us-east-2:123456789012:trail/MyTrail</code> </p> <p>If an empty list is specified, information for the trail in the current region is returned.</p> <ul> <li> <p>If an empty list is specified and <code>IncludeShadowTrails</code> is false, then information for all trails in the current region is returned.</p> </li> <li> <p>If an empty list is specified and IncludeShadowTrails is null or true, then information for all trails in the current region and any associated shadow trails in other regions is returned.</p> </li> </ul> <note> <p>If one or more trail names are specified, information is returned only if the names match the names of trails belonging only to the current region. To return information about a trail in another region, you must specify its trail ARN.</p> </note>"];
      include_shadow_trails: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether to include shadow trails in the response. A shadow trail is the replication in a region of a trail that was created in a different region, or in the case of an organization trail, the replication of an organization trail in member accounts. If you do not include shadow trails, organization trails in a member account and region replication trails will not be returned. The default is true.</p>"]}
    [@@ocaml.doc "<p>Returns information about the trail.</p>"]
    let make ?(trail_name_list= [])  ?include_shadow_trails  () =
      { trail_name_list; include_shadow_trails }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.include_shadow_trails
              (fun f -> ("include_shadow_trails", (Boolean.to_json f)));
           Some
             ("trail_name_list", (TrailNameList.to_json v.trail_name_list))])
    let of_json j =
      {
        trail_name_list =
          (TrailNameList.of_json
             (Util.of_option_exn (Json.lookup j "trail_name_list")));
        include_shadow_trails =
          (Util.option_map (Json.lookup j "include_shadow_trails")
             Boolean.of_json)
      }
  end[@@ocaml.doc "<p>Returns information about the trail.</p>"]
module DescribeTrailsResponse = DescribeTrailsResponse
type input = DescribeTrailsRequest.t
type output = DescribeTrailsResponse.t
type error = Errors_internal.t
let streaming = false
let service = "cloudtrail"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (DescribeTrailsRequest.to_query req)))) in
  (`POST, uri, (Headers.render (DescribeTrailsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (DescribeTrailsResponse.of_json json)
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