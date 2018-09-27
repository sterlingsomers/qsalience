import os
import pickle


allchunks = []

def convert_observation_to_chunks(obs):
    chunk = ['highest_obstacle_altitude', ['highest_obstacle_altitude', obs[0]],
             'hazard_level', ['hazard_level', obs[1]],
             'closeness_to_hiker', ['closeness_to_hiker', obs[2]],
             'heading_to_hiker', ['heading_to_hiker', obs[3]],
             'current_altitude', ['current_altitude', obs[4]],
             'current_heading', ['current_heading', obs[5]]]
    return chunk


def convert_data_to_chunks():
    data_path = 'data'
    datafiles = os.listdir('data')
    for file in [x for x in datafiles if '.pkl' in x]:
        path = os.path.join(data_path,file)
        data = pickle.load(open(path,'rb'))
        observations = data['observation']
        actions = data['action']
        action_map = {0:'left',1:'straight',2:'right',3:'forward_down',4:'drop_payload'}
        for obs,action in zip(observations,actions):
            chunk = ['highest_obstacle_altitude',['highest_obstacle_altitude',obs[0]],
                     'hazard_level',['hazard_level',obs[1]],
                     'closeness_to_hiker',['closeness_to_hiker',obs[2]],
                     'heading_to_hiker',['heading_to_hiker',obs[3]],
                     'current_altitude',['current_altitude',obs[4]],
                     'current_heading',['current_heading',obs[5]],
                     'action',['action',action]]
            if not chunk in allchunks:
                allchunks.append(chunk)

    print("done")

    with open('version1.chunks','wb') as handle:
        pickle.dump(allchunks,handle)

