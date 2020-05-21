open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeInstanceInformationRequest =
  struct
    type t =
      {
      instance_information_filter_list: InstanceInformationFilterList.t
        [@ocaml.doc
          "<p>This is a legacy method. We recommend that you don't use this method. Instead, use the <a>InstanceInformationFilter</a> action. The <code>InstanceInformationFilter</code> action enables you to return instance information by using tags that are specified as a key-value mapping. </p> <p>If you do use this method, then you can't use the <code>InstanceInformationFilter</code> action. Using this method and the <code>InstanceInformationFilter</code> action causes an exception error. </p>"];
      filters: InstanceInformationStringFilterList.t
        [@ocaml.doc
          "<p>One or more filters. Use a filter to return a more specific list of instances. You can filter on Amazon EC2 tag. Specify tags by using a key-value mapping.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of items to return for this call. The call also returns a token that you can specify in a subsequent call to get the next set of results. </p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. (You received this token from a previous call.)</p>"]}
    let make ?(instance_information_filter_list= [])  ?(filters= []) 
      ?max_results  ?next_token  () =
      { instance_information_filter_list; filters; max_results; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Some
             ("filters",
               (InstanceInformationStringFilterList.to_json v.filters));
           Some
             ("instance_information_filter_list",
               (InstanceInformationFilterList.to_json
                  v.instance_information_filter_list))])
    let of_json j =
      {
        instance_information_filter_list =
          (InstanceInformationFilterList.of_json
             (Util.of_option_exn
                (Json.lookup j "instance_information_filter_list")));
        filters =
          (InstanceInformationStringFilterList.of_json
             (Util.of_option_exn (Json.lookup j "filters")));
        max_results =
          (Util.option_map (Json.lookup j "max_results") Integer.of_json);
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DescribeInstanceInformationResult = DescribeInstanceInformationResult
type input = DescribeInstanceInformationRequest.t
type output = DescribeInstanceInformationResult.t
type error = Errors_internal.t
let streaming = false
let service = "ssm"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (DescribeInstanceInformationRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (DescribeInstanceInformationRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (DescribeInstanceInformationResult.of_json json)
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