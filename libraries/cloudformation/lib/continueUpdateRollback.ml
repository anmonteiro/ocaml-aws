open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ContinueUpdateRollbackInput =
  struct
    type t =
      {
      stack_name: String.t
        [@ocaml.doc
          "<p>The name or the unique ID of the stack that you want to continue rolling back.</p> <note> <p>Don't specify the name of a nested stack (a stack that was created by using the <code>AWS::CloudFormation::Stack</code> resource). Instead, use this operation on the parent stack (the stack that contains the <code>AWS::CloudFormation::Stack</code> resource).</p> </note>"];
      role_a_r_n: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of an AWS Identity and Access Management (IAM) role that AWS CloudFormation assumes to roll back the stack. AWS CloudFormation uses the role's credentials to make calls on your behalf. AWS CloudFormation always uses this role for all future operations on the stack. As long as users have permission to operate on the stack, AWS CloudFormation uses this role even if the users don't have permission to pass it. Ensure that the role grants least privilege.</p> <p>If you don't specify a value, AWS CloudFormation uses the role that was previously associated with the stack. If no role is available, AWS CloudFormation uses a temporary session that is generated from your user credentials.</p>"];
      resources_to_skip: ResourcesToSkip.t
        [@ocaml.doc
          "<p>A list of the logical IDs of the resources that AWS CloudFormation skips during the continue update rollback operation. You can specify only resources that are in the <code>UPDATE_FAILED</code> state because a rollback failed. You can't specify resources that are in the <code>UPDATE_FAILED</code> state for other reasons, for example, because an update was cancelled. To check why a resource update failed, use the <a>DescribeStackResources</a> action, and view the resource status reason. </p> <important> <p>Specify this property to skip rolling back resources that AWS CloudFormation can't successfully roll back. We recommend that you <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/troubleshooting.html#troubleshooting-errors-update-rollback-failed\"> troubleshoot</a> resources before skipping them. AWS CloudFormation sets the status of the specified resources to <code>UPDATE_COMPLETE</code> and continues to roll back the stack. After the rollback is complete, the state of the skipped resources will be inconsistent with the state of the resources in the stack template. Before performing another stack update, you must update the stack or resources to be consistent with each other. If you don't, subsequent stack updates might fail, and the stack will become unrecoverable. </p> </important> <p>Specify the minimum number of resources required to successfully roll back your stack. For example, a failed resource update might cause dependent resources to fail. In this case, it might not be necessary to skip the dependent resources. </p> <p>To skip resources that are part of nested stacks, use the following format: <code>NestedStackName.ResourceLogicalID</code>. If you want to specify the logical ID of a stack resource (<code>Type: AWS::CloudFormation::Stack</code>) in the <code>ResourcesToSkip</code> list, then its corresponding embedded stack must be in one of the following states: <code>DELETE_IN_PROGRESS</code>, <code>DELETE_COMPLETE</code>, or <code>DELETE_FAILED</code>. </p> <note> <p>Don't confuse a child stack's name with its corresponding logical ID defined in the parent stack. For an example of a continue update rollback operation with nested stacks, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-updating-stacks-continueupdaterollback.html#nested-stacks\">Using ResourcesToSkip to recover a nested stacks hierarchy</a>. </p> </note>"];
      client_request_token: String.t option
        [@ocaml.doc
          "<p>A unique identifier for this <code>ContinueUpdateRollback</code> request. Specify this token if you plan to retry requests so that AWS CloudFormation knows that you're not attempting to continue the rollback to a stack with the same name. You might retry <code>ContinueUpdateRollback</code> requests to ensure that AWS CloudFormation successfully received them.</p>"]}
    [@@ocaml.doc
      "<p>The input for the <a>ContinueUpdateRollback</a> action.</p>"]
    let make ~stack_name  ?role_a_r_n  ?(resources_to_skip= []) 
      ?client_request_token  () =
      { stack_name; role_a_r_n; resources_to_skip; client_request_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.client_request_token
              (fun f -> ("client_request_token", (String.to_json f)));
           Some
             ("resources_to_skip",
               (ResourcesToSkip.to_json v.resources_to_skip));
           Util.option_map v.role_a_r_n
             (fun f -> ("role_a_r_n", (String.to_json f)));
           Some ("stack_name", (String.to_json v.stack_name))])
    let parse xml =
      Some
        {
          stack_name =
            (Xml.required "StackName"
               (Util.option_bind (Xml.member "StackName" xml) String.parse));
          role_a_r_n =
            (Util.option_bind (Xml.member "RoleARN" xml) String.parse);
          resources_to_skip =
            (Util.of_option []
               (Util.option_bind (Xml.member "ResourcesToSkip" xml)
                  ResourcesToSkip.parse));
          client_request_token =
            (Util.option_bind (Xml.member "ClientRequestToken" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "StackName"
                    ([], (String.to_xml v.stack_name)))])
             @
             [Util.option_map v.role_a_r_n
                (fun f -> Ezxmlm.make_tag "RoleARN" ([], (String.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "ResourcesToSkip"
                       ([], (ResourcesToSkip.to_xml [x]))))
               v.resources_to_skip))
           @
           [Util.option_map v.client_request_token
              (fun f ->
                 Ezxmlm.make_tag "ClientRequestToken" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>The input for the <a>ContinueUpdateRollback</a> action.</p>"]
module Output = Aws.BaseTypes.Unit
type input = ContinueUpdateRollbackInput.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-05-15"]);
         ("Action", ["ContinueUpdateRollback"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ContinueUpdateRollbackInput.to_query req))))) in
  (`POST, uri, (Headers.render (ContinueUpdateRollbackInput.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) = `Ok ()
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