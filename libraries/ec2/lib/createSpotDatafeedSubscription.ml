open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateSpotDatafeedSubscriptionRequest =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc
          "<p>The Amazon S3 bucket in which to store the Spot Instance data feed.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      prefix: String.t option
        [@ocaml.doc "<p>A prefix for the data feed file names.</p>"]}
    [@@ocaml.doc
      "<p>Contains the parameters for CreateSpotDatafeedSubscription.</p>"]
    let make ~bucket  ?dry_run  ?prefix  () = { bucket; dry_run; prefix }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.prefix
              (fun f -> Query.Pair ("Prefix", (String.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some (Query.Pair ("Bucket", (String.to_query v.bucket)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.prefix
              (fun f -> ("prefix", (String.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "bucket"
               (Util.option_bind (Xml.member "bucket" xml) String.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          prefix = (Util.option_bind (Xml.member "prefix" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some (Ezxmlm.make_tag "bucket" ([], (String.to_xml v.bucket)))])
            @
            [Util.option_map v.dry_run
               (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.prefix
              (fun f -> Ezxmlm.make_tag "prefix" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for CreateSpotDatafeedSubscription.</p>"]
module CreateSpotDatafeedSubscriptionResult =
  CreateSpotDatafeedSubscriptionResult
type input = CreateSpotDatafeedSubscriptionRequest.t
type output = CreateSpotDatafeedSubscriptionResult.t
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
         ("Action", ["CreateSpotDatafeedSubscription"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (CreateSpotDatafeedSubscriptionRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateSpotDatafeedSubscriptionRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateSpotDatafeedSubscriptionResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateSpotDatafeedSubscriptionResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateSpotDatafeedSubscriptionResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateSpotDatafeedSubscriptionResult - missing field in body or children: "
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