open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ImportSnapshotRequest =
  struct
    type t =
      {
      client_data: ClientData.t option
        [@ocaml.doc "<p>The client-specific data.</p>"];
      client_token: String.t option
        [@ocaml.doc
          "<p>Token to enable idempotency for VM import requests.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>The description string for the import snapshot task.</p>"];
      disk_container: SnapshotDiskContainer.t option
        [@ocaml.doc "<p>Information about the disk container.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      encrypted: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the destination snapshot of the imported image should be encrypted. The default CMK for EBS is used unless you specify a non-default AWS Key Management Service (AWS KMS) CMK using <code>KmsKeyId</code>. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSEncryption.html\">Amazon EBS Encryption</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>An identifier for the symmetric AWS Key Management Service (AWS KMS) customer master key (CMK) to use when creating the encrypted snapshot. This parameter is only required if you want to use a non-default CMK; if this parameter is not specified, the default CMK for EBS is used. If a <code>KmsKeyId</code> is specified, the <code>Encrypted</code> flag must also be set. </p> <p>The CMK identifier may be provided in any of the following formats: </p> <ul> <li> <p>Key ID</p> </li> <li> <p>Key alias. The alias ARN contains the <code>arn:aws:kms</code> namespace, followed by the Region of the CMK, the AWS account ID of the CMK owner, the <code>alias</code> namespace, and then the CMK alias. For example, arn:aws:kms:<i>us-east-1</i>:<i>012345678910</i>:alias/<i>ExampleAlias</i>.</p> </li> <li> <p>ARN using key ID. The ID ARN contains the <code>arn:aws:kms</code> namespace, followed by the Region of the CMK, the AWS account ID of the CMK owner, the <code>key</code> namespace, and then the CMK ID. For example, arn:aws:kms:<i>us-east-1</i>:<i>012345678910</i>:key/<i>abcd1234-a123-456a-a12b-a123b4cd56ef</i>.</p> </li> <li> <p>ARN using key alias. The alias ARN contains the <code>arn:aws:kms</code> namespace, followed by the Region of the CMK, the AWS account ID of the CMK owner, the <code>alias</code> namespace, and then the CMK alias. For example, arn:aws:kms:<i>us-east-1</i>:<i>012345678910</i>:alias/<i>ExampleAlias</i>. </p> </li> </ul> <p>AWS parses <code>KmsKeyId</code> asynchronously, meaning that the action you call may appear to complete even though you provided an invalid identifier. This action will eventually report failure. </p> <p>The specified CMK must exist in the Region that the snapshot is being copied to.</p> <p>Amazon EBS does not support asymmetric CMKs.</p>"];
      role_name: String.t option
        [@ocaml.doc
          "<p>The name of the role to use when not using the default role, 'vmimport'.</p>"]}
    let make ?client_data  ?client_token  ?description  ?disk_container 
      ?dry_run  ?encrypted  ?kms_key_id  ?role_name  () =
      {
        client_data;
        client_token;
        description;
        disk_container;
        dry_run;
        encrypted;
        kms_key_id;
        role_name
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.role_name
              (fun f -> Query.Pair ("RoleName", (String.to_query f)));
           Util.option_map v.kms_key_id
             (fun f -> Query.Pair ("KmsKeyId", (String.to_query f)));
           Util.option_map v.encrypted
             (fun f -> Query.Pair ("Encrypted", (Boolean.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.disk_container
             (fun f ->
                Query.Pair
                  ("DiskContainer", (SnapshotDiskContainer.to_query f)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)));
           Util.option_map v.client_token
             (fun f -> Query.Pair ("ClientToken", (String.to_query f)));
           Util.option_map v.client_data
             (fun f -> Query.Pair ("ClientData", (ClientData.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.role_name
              (fun f -> ("role_name", (String.to_json f)));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)));
           Util.option_map v.encrypted
             (fun f -> ("encrypted", (Boolean.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.disk_container
             (fun f -> ("disk_container", (SnapshotDiskContainer.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)));
           Util.option_map v.client_data
             (fun f -> ("client_data", (ClientData.to_json f)))])
    let parse xml =
      Some
        {
          client_data =
            (Util.option_bind (Xml.member "ClientData" xml) ClientData.parse);
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          disk_container =
            (Util.option_bind (Xml.member "DiskContainer" xml)
               SnapshotDiskContainer.parse);
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          encrypted =
            (Util.option_bind (Xml.member "Encrypted" xml) Boolean.parse);
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse);
          role_name =
            (Util.option_bind (Xml.member "RoleName" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Util.option_map v.client_data
                     (fun f ->
                        Ezxmlm.make_tag "ClientData"
                          ([], (ClientData.to_xml f)))])
                 @
                 [Util.option_map v.client_token
                    (fun f ->
                       Ezxmlm.make_tag "ClientToken" ([], (String.to_xml f)))])
                @
                [Util.option_map v.description
                   (fun f ->
                      Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
               @
               [Util.option_map v.disk_container
                  (fun f ->
                     Ezxmlm.make_tag "DiskContainer"
                       ([], (SnapshotDiskContainer.to_xml f)))])
              @
              [Util.option_map v.dry_run
                 (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.encrypted
                (fun f ->
                   Ezxmlm.make_tag "Encrypted" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.kms_key_id
               (fun f -> Ezxmlm.make_tag "KmsKeyId" ([], (String.to_xml f)))])
           @
           [Util.option_map v.role_name
              (fun f -> Ezxmlm.make_tag "RoleName" ([], (String.to_xml f)))])
  end
module ImportSnapshotResult = ImportSnapshotResult
type input = ImportSnapshotRequest.t
type output = ImportSnapshotResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["ImportSnapshot"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ImportSnapshotRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ImportSnapshotRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ImportSnapshotResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ImportSnapshotResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ImportSnapshotResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ImportSnapshotResult - missing field in body or children: "
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