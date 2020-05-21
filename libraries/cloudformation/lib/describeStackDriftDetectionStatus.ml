open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeStackDriftDetectionStatusInput =
  struct
    type t =
      {
      stack_drift_detection_id: String.t
        [@ocaml.doc
          "<p>The ID of the drift detection results of this operation. </p> <p>AWS CloudFormation generates new results, with a new drift detection ID, each time this operation is run. However, the number of drift results AWS CloudFormation retains for any given stack, and for how long, may vary. </p>"]}
    let make ~stack_drift_detection_id  () = { stack_drift_detection_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("stack_drift_detection_id",
                (String.to_json v.stack_drift_detection_id))])
    let parse xml =
      Some
        {
          stack_drift_detection_id =
            (Xml.required "StackDriftDetectionId"
               (Util.option_bind (Xml.member "StackDriftDetectionId" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "StackDriftDetectionId"
                 ([], (String.to_xml v.stack_drift_detection_id)))])
  end
module DescribeStackDriftDetectionStatusOutput =
  DescribeStackDriftDetectionStatusOutput
type input = DescribeStackDriftDetectionStatusInput.t
type output = DescribeStackDriftDetectionStatusOutput.t
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
         ("Action", ["DescribeStackDriftDetectionStatus"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DescribeStackDriftDetectionStatusInput.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeStackDriftDetectionStatusInput.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DescribeStackDriftDetectionStatusResponse" (snd xml))
        (Xml.member "DescribeStackDriftDetectionStatusResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             DescribeStackDriftDetectionStatusOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeStackDriftDetectionStatusOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeStackDriftDetectionStatusOutput - missing field in body or children: "
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