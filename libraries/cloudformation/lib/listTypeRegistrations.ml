open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListTypeRegistrationsInput =
  struct
    type t =
      {
      type_: RegistryType.t option
        [@ocaml.doc
          "<p>The kind of type.</p> <p>Currently the only valid value is <code>RESOURCE</code>.</p>"];
      type_name: String.t option
        [@ocaml.doc
          "<p>The name of the type.</p> <p>Conditional: You must specify <code>TypeName</code> or <code>Arn</code>.</p>"];
      type_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the type.</p> <p>Conditional: You must specify <code>TypeName</code> or <code>Arn</code>.</p>"];
      registration_status_filter: RegistrationStatus.t option
        [@ocaml.doc
          "<p>The current status of the type registration request.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to be returned with a single call. If the number of available results exceeds this maximum, the response includes a <code>NextToken</code> value that you can assign to the <code>NextToken</code> request parameter to get the next set of results.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>If the previous paginated request didn't return all of the remaining results, the response object's <code>NextToken</code> parameter value is set to a token. To retrieve the next set of results, call this action again and assign that token to the request object's <code>NextToken</code> parameter. If there are no remaining results, the previous response object's <code>NextToken</code> parameter is set to <code>null</code>.</p>"]}
    let make ?type_  ?type_name  ?type_arn  ?registration_status_filter 
      ?max_results  ?next_token  () =
      {
        type_;
        type_name;
        type_arn;
        registration_status_filter;
        max_results;
        next_token
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Util.option_map v.registration_status_filter
             (fun f ->
                ("registration_status_filter",
                  (RegistrationStatus.to_json f)));
           Util.option_map v.type_arn
             (fun f -> ("type_arn", (String.to_json f)));
           Util.option_map v.type_name
             (fun f -> ("type_name", (String.to_json f)));
           Util.option_map v.type_
             (fun f -> ("type_", (RegistryType.to_json f)))])
    let parse xml =
      Some
        {
          type_ =
            (Util.option_bind (Xml.member "Type" xml) RegistryType.parse);
          type_name =
            (Util.option_bind (Xml.member "TypeName" xml) String.parse);
          type_arn =
            (Util.option_bind (Xml.member "TypeArn" xml) String.parse);
          registration_status_filter =
            (Util.option_bind (Xml.member "RegistrationStatusFilter" xml)
               RegistrationStatus.parse);
          max_results =
            (Util.option_bind (Xml.member "MaxResults" xml) Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.type_
                   (fun f ->
                      Ezxmlm.make_tag "Type" ([], (RegistryType.to_xml f)))])
               @
               [Util.option_map v.type_name
                  (fun f ->
                     Ezxmlm.make_tag "TypeName" ([], (String.to_xml f)))])
              @
              [Util.option_map v.type_arn
                 (fun f -> Ezxmlm.make_tag "TypeArn" ([], (String.to_xml f)))])
             @
             [Util.option_map v.registration_status_filter
                (fun f ->
                   Ezxmlm.make_tag "RegistrationStatusFilter"
                     ([], (RegistrationStatus.to_xml f)))])
            @
            [Util.option_map v.max_results
               (fun f ->
                  Ezxmlm.make_tag "MaxResults" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module ListTypeRegistrationsOutput = ListTypeRegistrationsOutput
type input = ListTypeRegistrationsInput.t
type output = ListTypeRegistrationsOutput.t
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-05-15"]); ("Action", ["ListTypeRegistrations"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ListTypeRegistrationsInput.to_query req))))) in
  (`POST, uri, (Headers.render (ListTypeRegistrationsInput.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "ListTypeRegistrationsResponse" (snd xml))
        (Xml.member "ListTypeRegistrationsResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ListTypeRegistrationsOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ListTypeRegistrationsOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListTypeRegistrationsOutput - missing field in body or children: "
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