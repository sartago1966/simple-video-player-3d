extends MeshInstance3D
class_name VideoPlayer3D

var video: VideoStreamPlayer

@export_group("Video Ready Configs")
@export var stream: VideoStream
@export var auto_play: bool = false
@export var loop: bool = false
@export_range(-80.0, 24.0, 0.01) var volume: float = 0


func _ready() -> void:
	material_override = material_override as StandardMaterial3D
	
	if not material_override:
		push_warning("[%s] You didn't create a material override of type StandardMaterial3D. A new one will be created." % [name])
		material_override = StandardMaterial3D.new()
	
	
	video = VideoStreamPlayer.new()
	video.autoplay = auto_play
	video.stream = stream
	video.loop = loop
	video.volume_db = volume
	add_child(video)
	video.set_visible(false)
	
	await get_tree().process_frame
	
	material_override.albedo_texture = video.get_video_texture()

func play() -> void:
	video.play()

func set_paused(paused_value: bool) -> void:
	video.paused = paused_value

func reset() -> void:
	video.stream_position = 0
