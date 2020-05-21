open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteBucketAnalyticsConfigurationRequest =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc
          "<p>The name of the bucket from which an analytics configuration is deleted.</p>"];
      id: String.t
        [@ocaml.doc
          "<p>The ID that identifies the analytics configuration.</p>"]}
    let make ~bucket  ~id  () = { bucket; id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("id", (String.to_query v.id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("id", (String.to_json v.id));
           Some ("bucket", (String.to_json v.bucket))])
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          id =
            (Xml.required "id"
               (Util.option_bind (Xml.member "id" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
           @ [Some (Ezxmlm.make_tag "id" ([], (String.to_xml v.id)))])
  end
module Output = Aws.BaseTypes.Unit
type input = DeleteBucketAnalyticsConfigurationRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/" ^ req.DeleteBucketAnalyticsConfigurationRequest.bucket) ^
               "?analytics")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render
               (DeleteBucketAnalyticsConfigurationRequest.to_query req)))) in
  (`DELETE, uri,
    (Headers.render
       (DeleteBucketAnalyticsConfigurationRequest.to_headers req)), "")
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