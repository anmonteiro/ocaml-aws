open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RecordHandlerProgressInput =
  struct
    type t =
      {
      bearer_token: String.t
        [@ocaml.doc
          "<p>Reserved for use by the <a href=\"https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/what-is-cloudformation-cli.html\">CloudFormation CLI</a>.</p>"];
      operation_status: OperationStatus.t
        [@ocaml.doc
          "<p>Reserved for use by the <a href=\"https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/what-is-cloudformation-cli.html\">CloudFormation CLI</a>.</p>"];
      current_operation_status: OperationStatus.t option
        [@ocaml.doc
          "<p>Reserved for use by the <a href=\"https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/what-is-cloudformation-cli.html\">CloudFormation CLI</a>.</p>"];
      status_message: String.t option
        [@ocaml.doc
          "<p>Reserved for use by the <a href=\"https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/what-is-cloudformation-cli.html\">CloudFormation CLI</a>.</p>"];
      error_code: HandlerErrorCode.t option
        [@ocaml.doc
          "<p>Reserved for use by the <a href=\"https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/what-is-cloudformation-cli.html\">CloudFormation CLI</a>.</p>"];
      resource_model: String.t option
        [@ocaml.doc
          "<p>Reserved for use by the <a href=\"https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/what-is-cloudformation-cli.html\">CloudFormation CLI</a>.</p>"];
      client_request_token: String.t option
        [@ocaml.doc
          "<p>Reserved for use by the <a href=\"https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/what-is-cloudformation-cli.html\">CloudFormation CLI</a>.</p>"]}
    let make ~bearer_token  ~operation_status  ?current_operation_status 
      ?status_message  ?error_code  ?resource_model  ?client_request_token 
      () =
      {
        bearer_token;
        operation_status;
        current_operation_status;
        status_message;
        error_code;
        resource_model;
        client_request_token
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.client_request_token
              (fun f -> ("client_request_token", (String.to_json f)));
           Util.option_map v.resource_model
             (fun f -> ("resource_model", (String.to_json f)));
           Util.option_map v.error_code
             (fun f -> ("error_code", (HandlerErrorCode.to_json f)));
           Util.option_map v.status_message
             (fun f -> ("status_message", (String.to_json f)));
           Util.option_map v.current_operation_status
             (fun f ->
                ("current_operation_status", (OperationStatus.to_json f)));
           Some
             ("operation_status",
               (OperationStatus.to_json v.operation_status));
           Some ("bearer_token", (String.to_json v.bearer_token))])
    let parse xml =
      Some
        {
          bearer_token =
            (Xml.required "BearerToken"
               (Util.option_bind (Xml.member "BearerToken" xml) String.parse));
          operation_status =
            (Xml.required "OperationStatus"
               (Util.option_bind (Xml.member "OperationStatus" xml)
                  OperationStatus.parse));
          current_operation_status =
            (Util.option_bind (Xml.member "CurrentOperationStatus" xml)
               OperationStatus.parse);
          status_message =
            (Util.option_bind (Xml.member "StatusMessage" xml) String.parse);
          error_code =
            (Util.option_bind (Xml.member "ErrorCode" xml)
               HandlerErrorCode.parse);
          resource_model =
            (Util.option_bind (Xml.member "ResourceModel" xml) String.parse);
          client_request_token =
            (Util.option_bind (Xml.member "ClientRequestToken" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Some
                    (Ezxmlm.make_tag "BearerToken"
                       ([], (String.to_xml v.bearer_token)))])
                @
                [Some
                   (Ezxmlm.make_tag "OperationStatus"
                      ([], (OperationStatus.to_xml v.operation_status)))])
               @
               [Util.option_map v.current_operation_status
                  (fun f ->
                     Ezxmlm.make_tag "CurrentOperationStatus"
                       ([], (OperationStatus.to_xml f)))])
              @
              [Util.option_map v.status_message
                 (fun f ->
                    Ezxmlm.make_tag "StatusMessage" ([], (String.to_xml f)))])
             @
             [Util.option_map v.error_code
                (fun f ->
                   Ezxmlm.make_tag "ErrorCode"
                     ([], (HandlerErrorCode.to_xml f)))])
            @
            [Util.option_map v.resource_model
               (fun f ->
                  Ezxmlm.make_tag "ResourceModel" ([], (String.to_xml f)))])
           @
           [Util.option_map v.client_request_token
              (fun f ->
                 Ezxmlm.make_tag "ClientRequestToken" ([], (String.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = RecordHandlerProgressInput.t
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
         [("Version", ["2010-05-15"]); ("Action", ["RecordHandlerProgress"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (RecordHandlerProgressInput.to_query req))))) in
  (`POST, uri, (Headers.render (RecordHandlerProgressInput.to_headers req)),
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