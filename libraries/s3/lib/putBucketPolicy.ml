open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutBucketPolicyRequest =
  struct
    type t =
      {
      bucket: String.t [@ocaml.doc "<p>The name of the bucket.</p>"];
      content_m_d5: String.t option
        [@ocaml.doc "<p>The MD5 hash of the request body.</p>"];
      confirm_remove_self_bucket_access: Boolean.t option
        [@ocaml.doc
          "<p>Set this parameter to true to confirm that you want to remove your permissions to change this bucket policy in the future.</p>"];
      policy: String.t
        [@ocaml.doc "<p>The bucket policy as a JSON document.</p>"]}
    let make ~bucket  ?content_m_d5  ?confirm_remove_self_bucket_access 
      ~policy  () =
      { bucket; content_m_d5; confirm_remove_self_bucket_access; policy }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.confirm_remove_self_bucket_access
              (fun f ->
                 Headers.Pair
                   ("x-amz-confirm-remove-self-bucket-access",
                     (Boolean.to_headers f)));
           Util.option_map v.content_m_d5
             (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("policy", (String.to_json v.policy));
           Util.option_map v.confirm_remove_self_bucket_access
             (fun f ->
                ("confirm_remove_self_bucket_access", (Boolean.to_json f)));
           Util.option_map v.content_m_d5
             (fun f -> ("content_m_d5", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse);
          confirm_remove_self_bucket_access =
            (Util.option_bind
               (Xml.member "x-amz-confirm-remove-self-bucket-access" xml)
               Boolean.parse);
          policy =
            (Xml.required "Policy"
               (Util.option_bind (Xml.member "Policy" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
             @
             [Util.option_map v.content_m_d5
                (fun f ->
                   Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
            @
            [Util.option_map v.confirm_remove_self_bucket_access
               (fun f ->
                  Ezxmlm.make_tag "x-amz-confirm-remove-self-bucket-access"
                    ([], (Boolean.to_xml f)))])
           @ [Some (Ezxmlm.make_tag "Policy" ([], (String.to_xml v.policy)))])
  end
module Output = Aws.BaseTypes.Unit
type input = PutBucketPolicyRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/" ^ req.PutBucketPolicyRequest.bucket) ^ "?policy")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (PutBucketPolicyRequest.to_query req)))) in
  (`PUT, uri, (Headers.render (PutBucketPolicyRequest.to_headers req)),
    req.PutBucketPolicyRequest.policy)
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