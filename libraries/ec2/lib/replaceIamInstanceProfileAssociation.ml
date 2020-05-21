open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ReplaceIamInstanceProfileAssociationRequest =
  struct
    type t =
      {
      iam_instance_profile: IamInstanceProfileSpecification.t
        [@ocaml.doc "<p>The IAM instance profile.</p>"];
      association_id: String.t
        [@ocaml.doc
          "<p>The ID of the existing IAM instance profile association.</p>"]}
    let make ~iam_instance_profile  ~association_id  () =
      { iam_instance_profile; association_id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("AssociationId", (String.to_query v.association_id)));
           Some
             (Query.Pair
                ("IamInstanceProfile",
                  (IamInstanceProfileSpecification.to_query
                     v.iam_instance_profile)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("association_id", (String.to_json v.association_id));
           Some
             ("iam_instance_profile",
               (IamInstanceProfileSpecification.to_json
                  v.iam_instance_profile))])
    let parse xml =
      Some
        {
          iam_instance_profile =
            (Xml.required "IamInstanceProfile"
               (Util.option_bind (Xml.member "IamInstanceProfile" xml)
                  IamInstanceProfileSpecification.parse));
          association_id =
            (Xml.required "AssociationId"
               (Util.option_bind (Xml.member "AssociationId" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "IamInstanceProfile"
                  ([],
                    (IamInstanceProfileSpecification.to_xml
                       v.iam_instance_profile)))])
           @
           [Some
              (Ezxmlm.make_tag "AssociationId"
                 ([], (String.to_xml v.association_id)))])
  end
module ReplaceIamInstanceProfileAssociationResult =
  ReplaceIamInstanceProfileAssociationResult
type input = ReplaceIamInstanceProfileAssociationRequest.t
type output = ReplaceIamInstanceProfileAssociationResult.t
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
         ("Action", ["ReplaceIamInstanceProfileAssociation"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (ReplaceIamInstanceProfileAssociationRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render
       (ReplaceIamInstanceProfileAssociationRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "ReplaceIamInstanceProfileAssociationResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             ReplaceIamInstanceProfileAssociationResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ReplaceIamInstanceProfileAssociationResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ReplaceIamInstanceProfileAssociationResult - missing field in body or children: "
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