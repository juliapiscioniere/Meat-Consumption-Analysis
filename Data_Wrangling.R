Established_Dem_data_df = data.frame(Established_Dem_data)
beef_slaughterers <- Established_Dem_data_df[which(Established_Dem_data_df$BeefSlaughter!='NULL'),]

Established_Dem_data_df_2 <- data.frame(MPI_Directory_by_Establishment_Number)
meat_slaughterers_2<- Established_Dem_data_df_2[grep("*Slaughter*",Established_Dem_data_df_2$Activities),]


international_beef_buffalo <- data.frame(beef_and_buffalo_meat_production_tonnes)
international_beef_2014 <- international_beef_buffalo[which(international_beef_buffalo$Year == '2014'),]

Established_Dem_Data_Final <- merge(Established_Dem_data_df, Established_Dem_data_df_2, 
                by.x = "EstablishmentNumber", by.y = "EstNumber", 
                all = TRUE, no.dups = TRUE)
