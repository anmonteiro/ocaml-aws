open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteStackInstancesInput =
  struct
    type t =
      {
      stack_set_name: String.t
        [@ocaml.doc
          "<p>The name or unique ID of the stack set that you want to delete stack instances for.</p>"];
      accounts: AccountList.t
        [@ocaml.doc
          "<p>The names of the AWS accounts that you want to delete stack instances for.</p>"];
      regions: RegionList.t
        [@ocaml.doc
          "<p>The regions where you want to delete stack set instances. </p>"];
      operation_preferences: StackSetOperationPreferences.t option
        [@ocaml.doc
          "<p>Preferences for how AWS CloudFormation performs this stack set operation.</p>"];
      retain_stacks: Boolean.t
        [@ocaml.doc
          "<p>Removes the stack instances from the specified stack set, but doesn't delete the stacks. You can't reassociate a retained stack or add an existing, saved stack to a new stack set.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-concepts.html#stackset-ops-options\">Stack set operation options</a>.</p>"];
      operation_id: String.t option
        [@ocaml.doc
          "<p>The unique identifier for this stack set operation. </p> <p>If you don't specify an operation ID, the SDK generates one automatically. </p> <p>The operation ID also functions as an idempotency token, to ensure that AWS CloudFormation performs the stack set operation only once, even if you retry the request multiple times. You can retry stack set operation requests to ensure that AWS CloudFormation successfully received them.</p> <p>Repeating this stack set operation with a new operation ID retries all stack instances whose status is <code>OUTDATED</code>. </p>"]}
    let make ~stack_set_name  ~accounts  ~regions  ?operation_preferences 
      ~retain_stacks  ?operation_id  () =
      {
        stack_set_name;
        accounts;
        regions;
        operation_preferences;
        retain_stacks;
        operation_id
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.operation_id
              (fun f -> ("operation_id", (String.to_json f)));
           Some ("retain_stacks", (Boolean.to_json v.retain_stacks));
           Util.option_map v.operation_preferences
             (fun f ->
                ("operation_preferences",
                  (StackSetOperationPreferences.to_json f)));
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
          operation_preferences =
            (Util.option_bind (Xml.member "OperationPreferences" xml)
               StackSetOperationPreferences.parse);
          retain_stacks =
            (Xml.required "RetainStacks"
               (Util.option_bind (Xml.member "RetainStacks" xml)
                  Boolean.parse));
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
             [Util.option_map v.operation_preferences
                (fun f ->
                   Ezxmlm.make_tag "OperationPreferences"
                     ([], (StackSetOperationPreferences.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "RetainStacks"
                  ([], (Boolean.to_xml v.retain_stacks)))])
           @
           [Util.option_map v.operation_id
              (fun f -> Ezxmlm.make_tag "OperationId" ([], (String.to_xml f)))])
  end
module DeleteStackInstancesOutput = DeleteStackInstancesOutput
type input = DeleteStackInstancesInput.t
type output = DeleteStackInstancesOutput.t
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-05-15"]); ("Action", ["DeleteStackInstances"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteStackInstancesInput.to_query req))))) in
  (`POST, uri, (Headers.render (DeleteStackInstancesInput.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DeleteStackInstancesResponse" (snd xml))
        (Xml.member "DeleteStackInstancesResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DeleteStackInstancesOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DeleteStackInstancesOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DeleteStackInstancesOutput - missing field in body or children: "
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