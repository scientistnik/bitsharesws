module BitShares
	class Api < Array
		attr_reader :name

		def initialize name, arr
			@name = name
			self.concat arr
		end

		def id
			@id ||= RPC.new(1, @name, [[]]).send
		end

		def rpc method, params
			RPC.new id, method, params
		end

		class << self

			def init
				return @apis unless @apis.nil?

				@apis = []
				@apis << API.new('database',
				%w(
					get_objects
					set_subscribe_callback
					set_pending_transaction_callback
					set_block_applied_callback
					cancel_all_subscriptions
					get_block_header
					get_block
					get_transaction
					get_recent_transaction_by_id
					get_chain_properties
					get_global_properties
					get_config
					get_chain_id
					get_dynamic_global_properties
					get_key_references
					get_accounts
					get_full_accounts
					get_account_by_name
					get_account_references
					lookup_account_names
					lookup_accounts
					get_account_count
					get_account_balances
					get_named_account_balances
					get_balance_objects
					get_vested_balances
					get_vesting_balances
					get_assets
					list_assets
					lookup_asset_symbols
					get_order_book
					get_limit_orders
					get_call_orders
					get_settle_orders
					get_margin_positions
					subscribe_to_market
					unsubscribe_from_market
					get_ticker
					get_24_volume
					get_trade_history
					get_witnesses
					get_witness_by_account
					lookup_witness_accounts
					get_witness_count
					get_committee_members
					get_committee_member_by_account
					lookup_committee_member_accounts
					get_workers_by_account
					lookup_vote_ids
					get_transaction_hex
					get_required_signatures
					get_potential_signatures
					get_potential_address_signatures
					verify_authority
					verify_account_authority
					validate_transaction
					get_required_fees
					get_proposed_transactions
					get_blinded_balances
				))

				@apis << API.new('history',
				%w(
					get_account_history
					get_fill_order_history
					get_market_history
					get_market_history_buckets
				))

				@apis << API.new('network_broadcast',
				%w(
					broadcast_transaction
					broadcast_transaction_with_callback
					broadcast_block
				))

				@apis << API.new('crypto',
				%w(
					blind_sign
					unblind_signature
					blind
					blind_sum
					range_get_info
					range_proof_sign
					verify_sum
					verify_range
					verify_range_proof_rewind
				))

				@apis << API.new('wallet',
				%w(
					help
					gethelp
					info
					about
					network_add_nodes
					network_get_connected_peers
					is_new
					is_locked
					lock
					unlock
					set_password
					dump_private_keys
					import_key
					import_accounts
					import_account_keys
					import_balance
					suggest_brain_key
					get_transaction_id
					get_private_key
					load_wallet_file
					normalize_brain_key
					save_wallet_file
					list_my_accounts
					list_accounts
					list_account_balances
					register_account
					upgrade_account
					create_account_with_brain_key
					transfer
					transfer2
					whitelist_account
					withdraw_vesting
					get_account
					get_account_id
					get_account_history
					approve_proposal
					sell_asset
					borrow_asset
					cancel_order
					settle_asset
					get_market_hostory
					get_limit_orders
					get_call_orders
					get_settle_orders
					list_assets
					create_asset
					update_asset
					update_bitasset
				))

				@apis
			end

			def get_id_by_name name
				@apis ||= init
				@apis.each do |api|
					return(api.id) if api.include? name
				end
				nil
			end

			def rpc method, params
				@apis ||= init
				RPC.new get_id_by_name(method), method, params
			end

			def [] name
				@apis ||= init
				@apis.each do |api|
					return api if api.name == name
				end
				nil
			end

		end
	end

	API = Api

end
