open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ResetCacheParameterGroupMessage =
  struct
    type t =
      {
      cache_parameter_group_name: String.t
        [@ocaml.doc "<p>The name of the cache parameter group to reset.</p>"];
      reset_all_parameters: Boolean.t option
        [@ocaml.doc
          "<p>If <code>true</code>, all parameters in the cache parameter group are reset to their default values. If <code>false</code>, only the parameters listed by <code>ParameterNameValues</code> are reset to their default values.</p> <p>Valid values: <code>true</code> | <code>false</code> </p>"];
      parameter_name_values: ParameterNameValueList.t
        [@ocaml.doc
          "<p>An array of parameter names to reset to their default values. If <code>ResetAllParameters</code> is <code>true</code>, do not use <code>ParameterNameValues</code>. If <code>ResetAllParameters</code> is <code>false</code>, you must specify the name of at least one parameter to reset.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>ResetCacheParameterGroup</code> operation.</p>"]
    let make ~cache_parameter_group_name  ?reset_all_parameters 
      ?(parameter_name_values= [])  () =
      {
        cache_parameter_group_name;
        reset_all_parameters;
        parameter_name_values
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("parameter_name_values",
                (ParameterNameValueList.to_json v.parameter_name_values));
           Util.option_map v.reset_all_parameters
             (fun f -> ("reset_all_parameters", (Boolean.to_json f)));
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
          reset_all_parameters =
            (Util.option_bind (Xml.member "ResetAllParameters" xml)
               Boolean.parse);
          parameter_name_values =
            (Util.of_option []
               (Util.option_bind (Xml.member "ParameterNameValues" xml)
                  ParameterNameValueList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "CacheParameterGroupName"
                   ([], (String.to_xml v.cache_parameter_group_name)))])
            @
            [Util.option_map v.reset_all_parameters
               (fun f ->
                  Ezxmlm.make_tag "ResetAllParameters"
                    ([], (Boolean.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ParameterNameValues"
                      ([], (ParameterNameValueList.to_xml [x]))))
              v.parameter_name_values))
  end[@@ocaml.doc
       "<p>Represents the input of a <code>ResetCacheParameterGroup</code> operation.</p>"]
module CacheParameterGroupNameMessage = CacheParameterGroupNameMessage
type input = ResetCacheParameterGroupMessage.t
type output = CacheParameterGroupNameMessage.t
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
         ("Action", ["ResetCacheParameterGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ResetCacheParameterGroupMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (ResetCacheParameterGroupMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "ResetCacheParameterGroupResponse" (snd xml))
        (Xml.member "ResetCacheParameterGroupResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CacheParameterGroupNameMessage.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CacheParameterGroupNameMessage."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CacheParameterGroupNameMessage - missing field in body or children: "
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