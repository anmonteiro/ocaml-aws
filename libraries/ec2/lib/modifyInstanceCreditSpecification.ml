open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyInstanceCreditSpecificationRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      client_token: String.t option
        [@ocaml.doc
          "<p>A unique, case-sensitive token that you provide to ensure idempotency of your modification request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html\">Ensuring Idempotency</a>.</p>"];
      instance_credit_specifications:
        InstanceCreditSpecificationListRequest.t
        [@ocaml.doc
          "<p>Information about the credit option for CPU usage.</p>"]}
    let make ?dry_run  ?client_token  ~instance_credit_specifications  () =
      { dry_run; client_token; instance_credit_specifications }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("InstanceCreditSpecification",
                   (InstanceCreditSpecificationListRequest.to_query
                      v.instance_credit_specifications)));
           Util.option_map v.client_token
             (fun f -> Query.Pair ("ClientToken", (String.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("instance_credit_specifications",
                (InstanceCreditSpecificationListRequest.to_json
                   v.instance_credit_specifications));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse);
          instance_credit_specifications =
            (Xml.required "InstanceCreditSpecification"
               (Util.option_bind
                  (Xml.member "InstanceCreditSpecification" xml)
                  InstanceCreditSpecificationListRequest.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.dry_run
                (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.client_token
               (fun f ->
                  Ezxmlm.make_tag "ClientToken" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "InstanceCreditSpecification"
                      ([],
                        (InstanceCreditSpecificationListRequest.to_xml [x]))))
              v.instance_credit_specifications))
  end
module ModifyInstanceCreditSpecificationResult =
  ModifyInstanceCreditSpecificationResult
type input = ModifyInstanceCreditSpecificationRequest.t
type output = ModifyInstanceCreditSpecificationResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]);
         ("Action", ["ModifyInstanceCreditSpecification"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (ModifyInstanceCreditSpecificationRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifyInstanceCreditSpecificationRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "ModifyInstanceCreditSpecificationResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             ModifyInstanceCreditSpecificationResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyInstanceCreditSpecificationResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyInstanceCreditSpecificationResult - missing field in body or children: "
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