open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DetectStackSetDriftInput =
  struct
    type t =
      {
      stack_set_name: String.t
        [@ocaml.doc
          "<p>The name of the stack set on which to perform the drift detection operation.</p>"];
      operation_preferences: StackSetOperationPreferences.t option ;
      operation_id: String.t option
        [@ocaml.doc "<p> <i>The ID of the stack set operation.</i> </p>"]}
    let make ~stack_set_name  ?operation_preferences  ?operation_id  () =
      { stack_set_name; operation_preferences; operation_id }
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
           Some ("stack_set_name", (String.to_json v.stack_set_name))])
    let parse xml =
      Some
        {
          stack_set_name =
            (Xml.required "StackSetName"
               (Util.option_bind (Xml.member "StackSetName" xml) String.parse));
          operation_preferences =
            (Util.option_bind (Xml.member "OperationPreferences" xml)
               StackSetOperationPreferences.parse);
          operation_id =
            (Util.option_bind (Xml.member "OperationId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "StackSetName"
                   ([], (String.to_xml v.stack_set_name)))])
            @
            [Util.option_map v.operation_preferences
               (fun f ->
                  Ezxmlm.make_tag "OperationPreferences"
                    ([], (StackSetOperationPreferences.to_xml f)))])
           @
           [Util.option_map v.operation_id
              (fun f -> Ezxmlm.make_tag "OperationId" ([], (String.to_xml f)))])
  end
module DetectStackSetDriftOutput = DetectStackSetDriftOutput
type input = DetectStackSetDriftInput.t
type output = DetectStackSetDriftOutput.t
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-05-15"]); ("Action", ["DetectStackSetDrift"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DetectStackSetDriftInput.to_query req))))) in
  (`POST, uri, (Headers.render (DetectStackSetDriftInput.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DetectStackSetDriftResponse" (snd xml))
        (Xml.member "DetectStackSetDriftResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DetectStackSetDriftOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DetectStackSetDriftOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DetectStackSetDriftOutput - missing field in body or children: "
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