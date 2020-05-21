open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module AddPermissionRequest =
  struct
    type t =
      {
      queue_url: String.t
        [@ocaml.doc
          "<p>The URL of the Amazon SQS queue to which permissions are added.</p> <p>Queue URLs and names are case-sensitive.</p>"];
      label: String.t
        [@ocaml.doc
          "<p>The unique identification of the permission you're setting (for example, <code>AliceSendMessage</code>). Maximum 80 characters. Allowed characters include alphanumeric characters, hyphens (<code>-</code>), and underscores (<code>_</code>).</p>"];
      a_w_s_account_ids: AWSAccountIdList.t
        [@ocaml.doc
          "<p>The AWS account number of the <a href=\"https://docs.aws.amazon.com/general/latest/gr/glos-chap.html#P\">principal</a> who is given permission. The principal must have an AWS account, but does not need to be signed up for Amazon SQS. For information about locating the AWS account identification, see <a href=\"https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-making-api-requests.html#sqs-api-request-authentication\">Your AWS Identifiers</a> in the <i>Amazon Simple Queue Service Developer Guide</i>.</p>"];
      actions: ActionNameList.t
        [@ocaml.doc
          "<p>The action the client wants to allow for the specified principal. Valid values: the name of any action or <code>*</code>.</p> <p>For more information about these actions, see <a href=\"https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-overview-of-managing-access.html\">Overview of Managing Access Permissions to Your Amazon Simple Queue Service Resource</a> in the <i>Amazon Simple Queue Service Developer Guide</i>.</p> <p>Specifying <code>SendMessage</code>, <code>DeleteMessage</code>, or <code>ChangeMessageVisibility</code> for <code>ActionName.n</code> also grants permissions for the corresponding batch versions of those actions: <code>SendMessageBatch</code>, <code>DeleteMessageBatch</code>, and <code>ChangeMessageVisibilityBatch</code>.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~queue_url  ~label  ~a_w_s_account_ids  ~actions  () =
      { queue_url; label; a_w_s_account_ids; actions }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("actions", (ActionNameList.to_json v.actions));
           Some
             ("a_w_s_account_ids",
               (AWSAccountIdList.to_json v.a_w_s_account_ids));
           Some ("label", (String.to_json v.label));
           Some ("queue_url", (String.to_json v.queue_url))])
    let parse xml =
      Some
        {
          queue_url =
            (Xml.required "QueueUrl"
               (Util.option_bind (Xml.member "QueueUrl" xml) String.parse));
          label =
            (Xml.required "Label"
               (Util.option_bind (Xml.member "Label" xml) String.parse));
          a_w_s_account_ids =
            (Xml.required "AWSAccountIds" (AWSAccountIdList.parse xml));
          actions = (Xml.required "Actions" (ActionNameList.parse xml))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "QueueUrl"
                    ([], (String.to_xml v.queue_url)))])
             @ [Some (Ezxmlm.make_tag "Label" ([], (String.to_xml v.label)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "AWSAccountIds"
                       ([], (AWSAccountIdList.to_xml [x]))))
               v.a_w_s_account_ids))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Actions"
                      ([], (ActionNameList.to_xml [x])))) v.actions))
  end[@@ocaml.doc "<p/>"]
module Output = Aws.BaseTypes.Unit
type input = AddPermissionRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "sqs"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2012-11-05"]); ("Action", ["AddPermission"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (AddPermissionRequest.to_query req))))) in
  (`POST, uri, (Headers.render (AddPermissionRequest.to_headers req)), "")
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