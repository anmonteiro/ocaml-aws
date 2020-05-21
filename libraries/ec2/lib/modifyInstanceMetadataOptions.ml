open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyInstanceMetadataOptionsRequest =
  struct
    type t =
      {
      instance_id: String.t [@ocaml.doc "<p>The ID of the instance.</p>"];
      http_tokens: HttpTokensState.t option
        [@ocaml.doc
          "<p>The state of token usage for your instance metadata requests. If the parameter is not specified in the request, the default state is <code>optional</code>.</p> <p>If the state is <code>optional</code>, you can choose to retrieve instance metadata with or without a signed token header on your request. If you retrieve the IAM role credentials without a token, the version 1.0 role credentials are returned. If you retrieve the IAM role credentials using a valid signed token, the version 2.0 role credentials are returned.</p> <p>If the state is <code>required</code>, you must send a signed token header with any instance metadata retrieval requests. In this state, retrieving the IAM role credential always returns the version 2.0 credentials; the version 1.0 credentials are not available.</p>"];
      http_put_response_hop_limit: Integer.t option
        [@ocaml.doc
          "<p>The desired HTTP PUT response hop limit for instance metadata requests. The larger the number, the further instance metadata requests can travel. If no parameter is specified, the existing state is maintained.</p> <p>Possible values: Integers from 1 to 64</p>"];
      http_endpoint: InstanceMetadataEndpointState.t option
        [@ocaml.doc
          "<p>This parameter enables or disables the HTTP metadata endpoint on your instances. If the parameter is not specified, the existing state is maintained.</p> <note> <p>If you specify a value of <code>disabled</code>, you will not be able to access your instance metadata.</p> </note>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~instance_id  ?http_tokens  ?http_put_response_hop_limit 
      ?http_endpoint  ?dry_run  () =
      {
        instance_id;
        http_tokens;
        http_put_response_hop_limit;
        http_endpoint;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.http_endpoint
             (fun f ->
                Query.Pair
                  ("HttpEndpoint",
                    (InstanceMetadataEndpointState.to_query f)));
           Util.option_map v.http_put_response_hop_limit
             (fun f ->
                Query.Pair ("HttpPutResponseHopLimit", (Integer.to_query f)));
           Util.option_map v.http_tokens
             (fun f ->
                Query.Pair ("HttpTokens", (HttpTokensState.to_query f)));
           Some (Query.Pair ("InstanceId", (String.to_query v.instance_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.http_endpoint
             (fun f ->
                ("http_endpoint", (InstanceMetadataEndpointState.to_json f)));
           Util.option_map v.http_put_response_hop_limit
             (fun f -> ("http_put_response_hop_limit", (Integer.to_json f)));
           Util.option_map v.http_tokens
             (fun f -> ("http_tokens", (HttpTokensState.to_json f)));
           Some ("instance_id", (String.to_json v.instance_id))])
    let parse xml =
      Some
        {
          instance_id =
            (Xml.required "InstanceId"
               (Util.option_bind (Xml.member "InstanceId" xml) String.parse));
          http_tokens =
            (Util.option_bind (Xml.member "HttpTokens" xml)
               HttpTokensState.parse);
          http_put_response_hop_limit =
            (Util.option_bind (Xml.member "HttpPutResponseHopLimit" xml)
               Integer.parse);
          http_endpoint =
            (Util.option_bind (Xml.member "HttpEndpoint" xml)
               InstanceMetadataEndpointState.parse);
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "InstanceId"
                     ([], (String.to_xml v.instance_id)))])
              @
              [Util.option_map v.http_tokens
                 (fun f ->
                    Ezxmlm.make_tag "HttpTokens"
                      ([], (HttpTokensState.to_xml f)))])
             @
             [Util.option_map v.http_put_response_hop_limit
                (fun f ->
                   Ezxmlm.make_tag "HttpPutResponseHopLimit"
                     ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.http_endpoint
               (fun f ->
                  Ezxmlm.make_tag "HttpEndpoint"
                    ([], (InstanceMetadataEndpointState.to_xml f)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module ModifyInstanceMetadataOptionsResult =
  ModifyInstanceMetadataOptionsResult
type input = ModifyInstanceMetadataOptionsRequest.t
type output = ModifyInstanceMetadataOptionsResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]);
         ("Action", ["ModifyInstanceMetadataOptions"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (ModifyInstanceMetadataOptionsRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifyInstanceMetadataOptionsRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ModifyInstanceMetadataOptionsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ModifyInstanceMetadataOptionsResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyInstanceMetadataOptionsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyInstanceMetadataOptionsResult - missing field in body or children: "
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