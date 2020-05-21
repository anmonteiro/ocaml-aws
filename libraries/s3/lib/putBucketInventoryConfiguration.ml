open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutBucketInventoryConfigurationRequest =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc
          "<p>The name of the bucket where the inventory configuration will be stored.</p>"];
      id: String.t
        [@ocaml.doc
          "<p>The ID used to identify the inventory configuration.</p>"];
      inventory_configuration: InventoryConfiguration.t
        [@ocaml.doc "<p>Specifies the inventory configuration.</p>"]}
    let make ~bucket  ~id  ~inventory_configuration  () =
      { bucket; id; inventory_configuration }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("id", (String.to_query v.id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("inventory_configuration",
                (InventoryConfiguration.to_json v.inventory_configuration));
           Some ("id", (String.to_json v.id));
           Some ("bucket", (String.to_json v.bucket))])
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          id =
            (Xml.required "id"
               (Util.option_bind (Xml.member "id" xml) String.parse));
          inventory_configuration =
            (Xml.required "InventoryConfiguration"
               (Util.option_bind (Xml.member "InventoryConfiguration" xml)
                  InventoryConfiguration.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
            @ [Some (Ezxmlm.make_tag "id" ([], (String.to_xml v.id)))])
           @
           [Some
              (Ezxmlm.make_tag "InventoryConfiguration"
                 ([],
                   (InventoryConfiguration.to_xml v.inventory_configuration)))])
  end
module Output = Aws.BaseTypes.Unit
type input = PutBucketInventoryConfigurationRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/" ^ req.PutBucketInventoryConfigurationRequest.bucket) ^
               "?inventory")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render
               (PutBucketInventoryConfigurationRequest.to_query req)))) in
  (`PUT, uri,
    (Headers.render (PutBucketInventoryConfigurationRequest.to_headers req)),
    (Ezxmlm.to_string
       [Ezxmlm.make_tag "InventoryConfiguration"
          ([],
            (InventoryConfiguration.to_xml
               req.PutBucketInventoryConfigurationRequest.inventory_configuration))]))
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