open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module SetStackPolicyInput =
  struct
    type t =
      {
      stack_name: String.t
        [@ocaml.doc
          "<p>The name or unique stack ID that you want to associate a policy with.</p>"];
      stack_policy_body: String.t option
        [@ocaml.doc
          "<p>Structure containing the stack policy body. For more information, go to <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/protect-stack-resources.html\"> Prevent Updates to Stack Resources</a> in the AWS CloudFormation User Guide. You can specify either the <code>StackPolicyBody</code> or the <code>StackPolicyURL</code> parameter, but not both.</p>"];
      stack_policy_u_r_l: String.t option
        [@ocaml.doc
          "<p>Location of a file containing the stack policy. The URL must point to a policy (maximum size: 16 KB) located in an S3 bucket in the same region as the stack. You can specify either the <code>StackPolicyBody</code> or the <code>StackPolicyURL</code> parameter, but not both.</p>"]}
    [@@ocaml.doc "<p>The input for the <a>SetStackPolicy</a> action.</p>"]
    let make ~stack_name  ?stack_policy_body  ?stack_policy_u_r_l  () =
      { stack_name; stack_policy_body; stack_policy_u_r_l }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.stack_policy_u_r_l
              (fun f -> ("stack_policy_u_r_l", (String.to_json f)));
           Util.option_map v.stack_policy_body
             (fun f -> ("stack_policy_body", (String.to_json f)));
           Some ("stack_name", (String.to_json v.stack_name))])
    let parse xml =
      Some
        {
          stack_name =
            (Xml.required "StackName"
               (Util.option_bind (Xml.member "StackName" xml) String.parse));
          stack_policy_body =
            (Util.option_bind (Xml.member "StackPolicyBody" xml) String.parse);
          stack_policy_u_r_l =
            (Util.option_bind (Xml.member "StackPolicyURL" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "StackName"
                   ([], (String.to_xml v.stack_name)))])
            @
            [Util.option_map v.stack_policy_body
               (fun f ->
                  Ezxmlm.make_tag "StackPolicyBody" ([], (String.to_xml f)))])
           @
           [Util.option_map v.stack_policy_u_r_l
              (fun f ->
                 Ezxmlm.make_tag "StackPolicyURL" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>The input for the <a>SetStackPolicy</a> action.</p>"]
module Output = Aws.BaseTypes.Unit
type input = SetStackPolicyInput.t
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
         [("Version", ["2010-05-15"]); ("Action", ["SetStackPolicy"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (SetStackPolicyInput.to_query req))))) in
  (`POST, uri, (Headers.render (SetStackPolicyInput.to_headers req)), "")
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