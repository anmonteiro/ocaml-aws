open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListBucketAnalyticsConfigurationsRequest =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc
          "<p>The name of the bucket from which analytics configurations are retrieved.</p>"];
      continuation_token: String.t option
        [@ocaml.doc
          "<p>The ContinuationToken that represents a placeholder from where this request should begin.</p>"]}
    let make ~bucket  ?continuation_token  () =
      { bucket; continuation_token }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.continuation_token
              (fun f ->
                 Query.Pair ("continuation-token", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.continuation_token
              (fun f -> ("continuation_token", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          continuation_token =
            (Util.option_bind (Xml.member "continuation-token" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
           @
           [Util.option_map v.continuation_token
              (fun f ->
                 Ezxmlm.make_tag "continuation-token" ([], (String.to_xml f)))])
  end
module ListBucketAnalyticsConfigurationsOutput =
  ListBucketAnalyticsConfigurationsOutput
type input = ListBucketAnalyticsConfigurationsRequest.t
type output = ListBucketAnalyticsConfigurationsOutput.t
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/" ^ req.ListBucketAnalyticsConfigurationsRequest.bucket) ^
               "?analytics")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render
               (ListBucketAnalyticsConfigurationsRequest.to_query req)))) in
  (`GET, uri,
    (Headers.render (ListBucketAnalyticsConfigurationsRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      match List.hd (snd xml) with
      | `El (_, xs) -> Some xs
      | _ ->
          raise
            (Failure
               "Could not find well formed ListBucketAnalyticsConfigurationsOutput.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             ListBucketAnalyticsConfigurationsOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ListBucketAnalyticsConfigurationsOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListBucketAnalyticsConfigurationsOutput - missing field in body or children: "
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