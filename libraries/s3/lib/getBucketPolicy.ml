open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetBucketPolicyRequest =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc
          "<p>The bucket name for which to get the bucket policy.</p>"]}
    let make ~bucket  () = { bucket }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
  end
module GetBucketPolicyOutput = GetBucketPolicyOutput
type input = GetBucketPolicyRequest.t
type output = (GetBucketPolicyOutput.t * Piaf.Body.t)
type error = Errors_internal.t
let streaming = true
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/" ^ req.GetBucketPolicyRequest.bucket) ^ "?policy")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (GetBucketPolicyRequest.to_query req)))) in
  (`GET, uri, (Headers.render (GetBucketPolicyRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`Streaming body) :
    [ `String of string  | `Streaming of Piaf.Body.t ]) = body[@@ocaml.warning
                                                                "-8"] in
  `Ok ((GetBucketPolicyOutput.of_headers headers), body)
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