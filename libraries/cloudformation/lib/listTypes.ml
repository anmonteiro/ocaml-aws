open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListTypesInput =
  struct
    type t =
      {
      visibility: Visibility.t option
        [@ocaml.doc
          "<p>The scope at which the type is visible and usable in CloudFormation operations.</p> <p>Valid values include:</p> <ul> <li> <p> <code>PRIVATE</code>: The type is only visible and usable within the account in which it is registered. Currently, AWS CloudFormation marks any types you create as <code>PRIVATE</code>.</p> </li> <li> <p> <code>PUBLIC</code>: The type is publically visible and usable within any Amazon account.</p> </li> </ul>"];
      provisioning_type: ProvisioningType.t option
        [@ocaml.doc
          "<p>The provisioning behavior of the type. AWS CloudFormation determines the provisioning type during registration, based on the types of handlers in the schema handler package submitted.</p> <p>Valid values include:</p> <ul> <li> <p> <code>FULLY_MUTABLE</code>: The type includes an update handler to process updates to the type during stack update operations.</p> </li> <li> <p> <code>IMMUTABLE</code>: The type does not include an update handler, so the type cannot be updated and must instead be replaced during stack update operations.</p> </li> <li> <p> <code>NON_PROVISIONABLE</code>: The type does not include create, read, and delete handlers, and therefore cannot actually be provisioned.</p> </li> </ul>"];
      deprecated_status: DeprecatedStatus.t option
        [@ocaml.doc
          "<p>The deprecation status of the types that you want to get summary information about.</p> <p>Valid values include:</p> <ul> <li> <p> <code>LIVE</code>: The type is registered for use in CloudFormation operations.</p> </li> <li> <p> <code>DEPRECATED</code>: The type has been deregistered and can no longer be used in CloudFormation operations. </p> </li> </ul>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to be returned with a single call. If the number of available results exceeds this maximum, the response includes a <code>NextToken</code> value that you can assign to the <code>NextToken</code> request parameter to get the next set of results.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>If the previous paginated request didn't return all of the remaining results, the response object's <code>NextToken</code> parameter value is set to a token. To retrieve the next set of results, call this action again and assign that token to the request object's <code>NextToken</code> parameter. If there are no remaining results, the previous response object's <code>NextToken</code> parameter is set to <code>null</code>.</p>"]}
    let make ?visibility  ?provisioning_type  ?deprecated_status 
      ?max_results  ?next_token  () =
      {
        visibility;
        provisioning_type;
        deprecated_status;
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
           Util.option_map v.deprecated_status
             (fun f -> ("deprecated_status", (DeprecatedStatus.to_json f)));
           Util.option_map v.provisioning_type
             (fun f -> ("provisioning_type", (ProvisioningType.to_json f)));
           Util.option_map v.visibility
             (fun f -> ("visibility", (Visibility.to_json f)))])
    let parse xml =
      Some
        {
          visibility =
            (Util.option_bind (Xml.member "Visibility" xml) Visibility.parse);
          provisioning_type =
            (Util.option_bind (Xml.member "ProvisioningType" xml)
               ProvisioningType.parse);
          deprecated_status =
            (Util.option_bind (Xml.member "DeprecatedStatus" xml)
               DeprecatedStatus.parse);
          max_results =
            (Util.option_bind (Xml.member "MaxResults" xml) Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.visibility
                  (fun f ->
                     Ezxmlm.make_tag "Visibility" ([], (Visibility.to_xml f)))])
              @
              [Util.option_map v.provisioning_type
                 (fun f ->
                    Ezxmlm.make_tag "ProvisioningType"
                      ([], (ProvisioningType.to_xml f)))])
             @
             [Util.option_map v.deprecated_status
                (fun f ->
                   Ezxmlm.make_tag "DeprecatedStatus"
                     ([], (DeprecatedStatus.to_xml f)))])
            @
            [Util.option_map v.max_results
               (fun f ->
                  Ezxmlm.make_tag "MaxResults" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module ListTypesOutput = ListTypesOutput
type input = ListTypesInput.t
type output = ListTypesOutput.t
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2010-05-15"]); ("Action", ["ListTypes"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ListTypesInput.to_query req))))) in
  (`POST, uri, (Headers.render (ListTypesInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "ListTypesResponse" (snd xml))
        (Xml.member "ListTypesResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ListTypesOutput.parse)
          (BadResponse
             { body; message = "Could not find well formed ListTypesOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListTypesOutput - missing field in body or children: "
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