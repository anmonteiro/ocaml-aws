(** "<p>Delivers a message to the specified queue.</p> <important> <p>A message can include only XML, JSON, and unformatted text. The following Unicode characters are allowed:</p> <p> <code>#x9</code> | <code>#xA</code> | <code>#xD</code> | <code>#x20</code> to <code>#xD7FF</code> | <code>#xE000</code> to <code>#xFFFD</code> | <code>#x10000</code> to <code>#x10FFFF</code> </p> <p>Any characters not included in this list will be rejected. For more information, see the <a href=\"http://www.w3.org/TR/REC-xml/#charsets\">W3C specification for characters</a>.</p> </important>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module SendMessageRequest :
sig
  type t =
    {
    queue_url: String.t ;
    message_body: String.t ;
    delay_seconds: Integer.t option ;
    message_attributes: MessageBodyAttributeMap.t option ;
    message_system_attributes: MessageBodySystemAttributeMap.t option ;
    message_deduplication_id: String.t option ;
    message_group_id: String.t option }[@@ocaml.doc "<p/>"]
  val make :
    queue_url:String.t ->
      message_body:String.t ->
        ?delay_seconds:Integer.t ->
          ?message_attributes:MessageBodyAttributeMap.t ->
            ?message_system_attributes:MessageBodySystemAttributeMap.t ->
              ?message_deduplication_id:String.t ->
                ?message_group_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module SendMessageResult = SendMessageResult
type input = SendMessageRequest.t
type output = SendMessageResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error