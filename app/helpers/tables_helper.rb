module TablesHelper
    def opened_at(table)
        Table.find(table.id).requests.pluck(:created_at).sort().first.strftime("%d%m%Y %I:%M")
    end

    def count_requests(table)
        requests = Table.find(table.id).requests
        bill = []
        requests.map(&:amounts).each do |amount|
            amount.each do |requested_item|
                bill << requested_item.amount * Item.find(requested_item.item_id).price
            end
        end
        bill.sum()
    end
end
