open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UpdateStackInstancesInput =
  struct
    type t =
      {
      stack_set_name: String.t
        [@ocaml.doc
          "<p>The name or unique ID of the stack set associated with the stack instances.</p>"];
      accounts: AccountList.t
        [@ocaml.doc
          "<p>The names of one or more AWS accounts for which you want to update parameter values for stack instances. The overridden parameter values will be applied to all stack instances in the specified accounts and regions.</p>"];
      regions: RegionList.t
        [@ocaml.doc
          "<p>The names of one or more regions in which you want to update parameter values for stack instances. The overridden parameter values will be applied to all stack instances in the specified accounts and regions.</p>"];
      parameter_overrides: Parameters.t
        [@ocaml.doc
          "<p> A list of input parameters whose values you want to update for the specified stack instances. </p> <p>Any overridden parameter values will be applied to all stack instances in the specified accounts and regions. When specifying parameters and their values, be aware of how AWS CloudFormation sets parameter values during stack instance update operations:</p> <ul> <li> <p>To override the current value for a parameter, include the parameter and specify its value.</p> </li> <li> <p>To leave a parameter set to its present value, you can do one of the following:</p> <ul> <li> <p>Do not include the parameter in the list.</p> </li> <li> <p>Include the parameter and specify <code>UsePreviousValue</code> as <code>true</code>. (You cannot specify both a value and set <code>UsePreviousValue</code> to <code>true</code>.)</p> </li> </ul> </li> <li> <p>To set all overridden parameter back to the values specified in the stack set, specify a parameter list but do not include any parameters.</p> </li> <li> <p>To leave all parameters set to their present values, do not specify this property at all.</p> </li> </ul> <p>During stack set updates, any parameter values overridden for a stack instance are not updated, but retain their overridden value.</p> <p>You can only override the parameter <i>values</i> that are specified in the stack set; to add or delete a parameter itself, use <code>UpdateStackSet</code> to update the stack set template. If you add a parameter to a template, before you can override the parameter value specified in the stack set you must first use <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_UpdateStackSet.html\">UpdateStackSet</a> to update all stack instances with the updated template and parameter value specified in the stack set. Once a stack instance has been updated with the new parameter, you can then override the parameter value using <code>UpdateStackInstances</code>.</p>"];
      operation_preferences: StackSetOperationPreferences.t option
        [@ocaml.doc
          "<p>Preferences for how AWS CloudFormation performs this stack set operation.</p>"];
      operation_id: String.t option
        [@ocaml.doc
          "<p>The unique identifier for this stack set operation. </p> <p>The operation ID also functions as an idempotency token, to ensure that AWS CloudFormation performs the stack set operation only once, even if you retry the request multiple times. You might retry stack set operation requests to ensure that AWS CloudFormation successfully received them.</p> <p>If you don't specify an operation ID, the SDK generates one automatically. </p>"]}
    let make ~stack_set_name  ~accounts  ~regions  ?(parameter_overrides= [])
       ?operation_preferences  ?operation_id  () =
      {
        stack_set_name;
        accounts;
        regions;
        parameter_overrides;
        operation_preferences;
        operation_id
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.operation_id
              (fun f -> ("operation_id", (String.to_json f)));
           Util.option_map v.operation_preferences
             (fun f ->
                ("operation_preferences",
                  (StackSetOperationPreferences.to_json f)));
           Some
             ("parameter_overrides",
               (Parameters.to_json v.parameter_overrides));
           Some ("regions", (RegionList.to_json v.regions));
           Some ("accounts", (AccountList.to_json v.accounts));
           Some ("stack_set_name", (String.to_json v.stack_set_name))])
    let parse xml =
      Some
        {
          stack_set_name =
            (Xml.required "StackSetName"
               (Util.option_bind (Xml.member "StackSetName" xml) String.parse));
          accounts =
            (Xml.required "Accounts"
               (Util.option_bind (Xml.member "Accounts" xml)
                  AccountList.parse));
          regions =
            (Xml.required "Regions"
               (Util.option_bind (Xml.member "Regions" xml) RegionList.parse));
          parameter_overrides =
            (Util.of_option []
               (Util.option_bind (Xml.member "ParameterOverrides" xml)
                  Parameters.parse));
          operation_preferences =
            (Util.option_bind (Xml.member "OperationPreferences" xml)
               StackSetOperationPreferences.parse);
          operation_id =
            (Util.option_bind (Xml.member "OperationId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Some
                   (Ezxmlm.make_tag "StackSetName"
                      ([], (String.to_xml v.stack_set_name)))])
               @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "Accounts"
                          ([], (AccountList.to_xml [x])))) v.accounts))
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "Regions"
                         ([], (RegionList.to_xml [x])))) v.regions))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "ParameterOverrides"
                        ([], (Parameters.to_xml [x])))) v.parameter_overrides))
            @
            [Util.option_map v.operation_preferences
               (fun f ->
                  Ezxmlm.make_tag "OperationPreferences"
                    ([], (StackSetOperationPreferences.to_xml f)))])
           @
           [Util.option_map v.operation_id
              (fun f -> Ezxmlm.make_tag "OperationId" ([], (String.to_xml f)))])
  end
module UpdateStackInstancesOutput = UpdateStackInstancesOutput
type input = UpdateStackInstancesInput.t
type output = UpdateStackInstancesOutput.t
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-05-15"]); ("Action", ["UpdateStackInstances"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (UpdateStackInstancesInput.to_query req))))) in
  (`POST, uri, (Headers.render (UpdateStackInstancesInput.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "UpdateStackInstancesResponse" (snd xml))
        (Xml.member "UpdateStackInstancesResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp UpdateStackInstancesOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed UpdateStackInstancesOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing UpdateStackInstancesOutput - missing field in body or children: "
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