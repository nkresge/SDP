function Get-K2RFReplicationSessions {
    param(
        [parameter()]
        [Alias("CommonSnapshotsCount")]
        [int] $common_snapshots_count,
        [parameter()]
        [Alias("CurrentRole")]
        [string] $current_role,
        [parameter()]
        [Alias("CurrentSnapshot")]
        [string] $current_snapshot,
        [parameter()]
        [Alias("CurrentSnapshotProgress")]
        [int] $current_snapshot_progress,
        [parameter()]
        [Alias("EstimatedRemainingTime")]
        [string] $estimated_remaining_time,
        [parameter()]
        [Alias("ExternalRetentionPolicy")]
        [string] $external_retention_policy,
        [parameter()]
        [Alias("ContainedIn")]
        [int] $id,
        [parameter()]
        [Alias("LatestReplicatedSnapshot")]
        [string] $latest_replicated_snapshot,
        [parameter()]
        [Alias("LocalVolumeGroup")]
        [string] $local_volume_group,
        [parameter()]
        [Alias("ContainedIn")]
        [string] $name,
        [parameter()]
        [Alias("NextSnapshot")]
        [string] $next_snapshot,
        [parameter()]
        [Alias("ContainedIn")]
        [bool] $primary,
        [parameter()]
        [Alias("RemoteReplicationSessionId")]
        [int] $remote_replication_session_id,
        [parameter()]
        [Alias("RemoteReplicationSessionName")]
        [string] $remote_replication_session_name,
        [parameter()]
        [Alias("ReplicationPeerK2array")]
        [string] $replication_peer_k2array,
        [parameter()]
        [Alias("ReplicationPeerVolumeGroup")]
        [string] $replication_peer_volume_group,
        [parameter()]
        [Alias("ReplicationRpoHistory")]
        [string] $replication_rpo_history,
        [parameter()]
        [Alias("RestoredSnapshot")]
        [string] $restored_snapshot,
        [parameter()]
        [Alias("RetentionPolicy")]
        [string] $retention_policy,
        [parameter()]
        [Alias("ContainedIn")]
        [int] $rpo,
        [parameter()]
        [Alias("ContainedIn")]
        [string] $state,
        [parameter()]
        [Alias("ContainedIn")]
        [bool] $stopped,
        [parameter()]
        [Alias("SuspendReason")]
        [string] $suspend_reason,
        [parameter()]
        [Alias("SuspendReasonCode")]
        [string] $suspend_reason_code,
        [parameter()]
        [string] $k2context = "k2rfconnection"
    )

    $endpoint = "replication/sessions"

    if ($PSBoundParameters.Keys.Contains('Verbose')) {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -Verbose -k2context $k2context
    } else {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
    }
    return $results.hits
}
